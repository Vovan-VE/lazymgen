unit module App::Format::Yii2;

use App::Core;
use App::Parsing;

class Yii2Statement is Statement is export {
    method filter-name(Str:D $name --> Str:D) {
        $name
            .subst(/ :i <-[ a..z \d ]>+ /, '_', :g)
            .subst(/ ^ _+ || _+ $ /, '', :g)
            || 'noname';
    }
}

class Yii2Migration is Migration is export {
    has Str:D $.indent = '';
}

class Yii2Format is TransformFormat is export {
    my constant UNSIGNED         = '->unsigned()';

    my constant %types = {
        primary      => {:t<primaryKey>,    :D},
        uprimary     => {:t<primaryKey>,    :D, :a(UNSIGNED)},
        primary-big  => {:t<bigPrimaryKey>, :D},
        uprimary-big => {:t<bigPrimaryKey>, :D, :a(UNSIGNED)},
        char         => True,
        string       => True,
        text         => True,
        int16        => 'smallInteger',
        uint16       => ['smallInteger', UNSIGNED],
        int          => 'integer',
        uint         => ['integer', UNSIGNED],
        bigint       => 'bigInteger',
        int64        => 'bigInteger',
        uint64       => ['bigInteger', UNSIGNED],
        float        => True,
        double       => True,
        decimal      => True,
        date         => True,
        datetime     => 'dateTime',
        time         => True,
        timestamp    => True,
        binary       => True,
        bool         => 'boolean',
        money        => True,
    };

    my constant FK_ACTION = {
        (FK_RESTRICT) => 'RESTRICT',
        (FK_CASCADE)  => 'CASCADE',
        (FK_SET_NULL) => 'SET NULL',
    };

    my constant S_FK = 'fk';
    my constant S_PK = 'pk';
    my constant S_IDX = 'idx';

    method migration-class(--> Migration:U) { Yii2Migration }

    method init-header(Match:D $source) {
        (
            "Format: Yii2",
            "",
            |callsame,
        );
    }

    method data-types(--> Iterable) {
        %types.keys;
    }

    method create-table($s --> Yii2Statement) {
        my ($table, $columns) = $s<table columns>;
        Yii2Statement.new(
            :name("create_{$table}"),
            :code(
                '$tableOptions = null;' ~ "\n" ~
                q[if ($this->db->driverName === 'mysql') {] ~ "\n" ~
                (
                    '// https://stackoverflow.com/q/766809' ~ "\n" ~
                    q[$tableOptions = 'CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=InnoDB';]
                ).indent(4) ~ "\n" ~
                "}\n" ~
                "\n" ~
                '$this->createTable(' ~ self.table-string($table) ~ ", [\n" ~
                @($columns).map({
                    my ($name, $type) = .<name type>;
                    self.string($name) ~ ' => ' ~ self.column-type($type) ~ ',';
                }).join("\n").indent(4) ~ "\n" ~
                '], $tableOptions);'
            ),
        );
    }
    method drop-table($s --> Yii2Statement) {
        my ($table) = $s<table>;
        Yii2Statement.new(
            :name("drop_{$table}"),
            :code('$this->dropTable(' ~ self.table-string($table) ~ ');')
        );
    }

    method add-column($s --> Yii2Statement) {
        my ($table, $column, $type, $pos) = $s<table name type position>;
        Yii2Statement.new(
            :name("add_{$table}_{$column}"),
            :code(
                '$this->addColumn(' ~ "\n" ~
                (
                    self.table-string($table) ~ ",\n" ~
                    self.string($column) ~ ",\n" ~
                    self.column-type-pos($type, $pos)
                ).indent(4) ~ "\n" ~
                ');'
            )
        );
    }
    method drop-column($s --> Yii2Statement) {
        my ($table, $column) = $s<table name>;
        Yii2Statement.new(
            :name("drop_{$table}_{$column}"),
            :code(
                '$this->dropColumn(' ~
                self.table-string($table) ~ ', ' ~
                self.string($column) ~
                ');'
            )
        );
    }

    method add-primary-key($s --> Yii2Statement) {
        self!index-common($s, 'add_', 'addPrimaryKey', S_PK, :cols);
    }
    method drop-primary-key($s --> Yii2Statement) {
        self!index-common($s, 'drop_', 'dropPrimaryKey', S_PK);
    }

    method add-unique-key($s --> Yii2Statement) {
        self!index-common($s, 'add_', 'createIndex', S_IDX, :cols, :tag<true>);
    }
    method drop-unique-key($s --> Yii2Statement) {
        self!index-common($s, 'drop_', 'dropIndex', S_IDX);
    }

    method add-index($s --> Yii2Statement) {
        self!index-common($s, 'add_', 'createIndex', S_IDX, :cols, :tag<false>);
    }
    method drop-index($s --> Yii2Statement) {
        self!index-common($s, 'drop_', 'dropIndex', S_IDX);
    }

    method !index-common($s, Str $namePrefix, Str $method, Str $prefix, Bool:D :$cols = False, Str :$tag --> Yii2Statement) {
        my ($alias, $table, $columns) = $s<alias table columns>;
        my $index_name = self.index-name($prefix, $alias, $s);
        Yii2Statement.new(
            :name($namePrefix ~ $index_name),
            :code(
                '$this->' ~ $method ~ "(\n" ~
                (
                    self.string($index_name) ~ ",\n" ~
                    self.table-string($table) ~
                    ($cols
                        ?? ",\n[" ~
                        @$columns.map({
                            self.string($_)
                        }).join(', ') ~ ']'
                        !! ''
                    ) ~
                    ($tag
                        ?? ",\n$tag"
                        !! ''
                    )
                ).indent(4) ~ "\n" ~
                ');'
            )
        );
    }

    method add-foreigh-key($s, Bool:D :$back = False --> Yii2Statement) {
        my ($a, $f, $t, $d, $u) = $s<alias child parent delete update>;
        ($f, $t) = $t, $f if $back;
        my $index_name = self.index-name(S_FK, $a, $f, $t);
        Yii2Statement.new(
            :name("add_$index_name"),
            :code(
                '$this->addForeignKey(' ~ "\n" ~
                (
                    self.string($index_name) ~ ",\n" ~
                    self.table-string($f<table>) ~ ', [' ~
                    @($f<columns>).map({ self.string($_) }).join(', ') ~
                    "],\n" ~
                    self.table-string($t<table>) ~ ', [' ~
                    @($t<columns>).map({ self.string($_) }).join(', ') ~
                    "],\n" ~
                    self.string(FK_ACTION{$d}) ~ ",\n" ~
                    self.string(FK_ACTION{$u})
                ).indent(4) ~ "\n" ~
                ');'
            )
        );
    }
    method drop-foreign-key($s, Bool:D :$back = False --> Yii2Statement) {
        my ($a, $f, $t) = $s<alias child parent>;
        ($f, $t) = $t, $f if $back;
        my $index_name = self.index-name(S_FK, $a, $f, $t);
        Yii2Statement.new(
            :name("drop_$index_name"),
            :code(
                '$this->dropForeignKey(' ~ "\n" ~
                (
                    self.string($index_name) ~ ",\n" ~
                    self.table-string($f<table>)
                ).indent(4) ~ "\n" ~
                ');'
            )
        );
    }

    method rename-table($s, Bool:D :$back = False --> Yii2Statement) {
        my ($from_table, $to_table) = $s<table to>;
        ($from_table, $to_table) = $to_table, $from_table if $back;
        Yii2Statement.new(
            :name("rename_{$from_table}_{$to_table}"),
            :code(
                '$this->renameTable(' ~
                self.table-string($from_table) ~ ', ' ~
                self.table-string($to_table) ~ ');'
            )
        );
    }

    method alter-column-name($s, Bool:D :$back = False --> Yii2Statement) {
        my ($table, $from_name, $to_name) = $s<table name to>;
        ($from_name, $to_name) = $to_name, $from_name if $back;
        self!rename-column($table, $from_name, $to_name);
    }
    method alter-column-type($s, Bool:D :$back = False --> Yii2Statement) {
        my ($table, $from-name, $from-type, $to-name, $to-type) = $s<table name from to-name to-type>;

        if !$to-name || $to-type.defined && $from-type !eqv $to-type {
            if $to-name && $from-name ne $to-name {
                self.throw-unsupported('Yii2 cannot change column name and type in one operation');
            }

            my ($type, $pos) = ($back ?? $from-type !! $to-type)<type position>;
            Yii2Statement.new(
                :name("alter_{$table}_{$from-name}"),
                :code(
                    '$this->alterColumn(' ~ "\n" ~
                    (
                        self.table-string($table) ~ ",\n" ~
                        self.string($from-name) ~ ",\n" ~
                        self.column-type-pos($type, $pos)
                    ).indent(4) ~ "\n" ~
                    ');'
                )
            );
        }
        else {
            ($from-name, $to-name) = $to-name, $from-name if $back;
            self!rename-column($table, $from-name, $to-name);
        }
    }
    method !rename-column(Str:D $table, Str:D $from-name, Str:D $to-name --> Yii2Statement) {
        Yii2Statement.new(
            :name("rename_{$table}_{$from-name}_{$to-name}"),
            :code(
                '$this->renameColumn(' ~
                self.table-string($table) ~ ', ' ~
                self.string($from-name) ~ ', ' ~
                self.string($to-name) ~ ');'
            )
        );
    }

    method data-statement($s, Bool:D :$back = False --> Yii2Statement) {
        Yii2Statement.new(
            :name('update')
            :code(
                '// TODO: ' ~
                ($back
                    ?? 'undo that updates'
                    !! 'add some updates'
                )
            ),
            :is-dml,
        );
    }

    method column-type-pos($t, $pos --> Str) {
        my $type = self.column-type($t);
        return $type without $pos;
        return $type ~ '->first()' if POS_FIRST eq $pos<pos>;
        return $type ~ '->after(' ~ self.string($pos<name>) ~ ')';
    }

    method column-type($t --> Str) {
        my ($name, $params, $null, $has-default, $default) = $t<name params null default default-value>;
        my $params-joined = @($params)».source.join(', ');

        %types{$name}:exists or self.throw-unsupported("unknown type `$name`");
        my ($type, $appendix, $defined) = do given %types{$name} {
            when * === True { ($name,) }
            when Str:D { (.self,) }
            when List { .self }
            when Map { @(.self<t a D>) }
            default {
                die "bad type declaration for `$name`";
            }
        };

        my $ret = '$this->' ~ $type ~ '(' ~ $params-joined ~ ')';
        if $defined {
            if $null {
                self.throw-unsupported(
                    "type `$name` (`$type`) is strictly defined so it cannot be NULL"
                );
            }
        }
        else {
            $ret ~= '->notNull()' unless $null;
        }
        $ret ~= '->defaultValue(' ~ self.default-value($default) ~ ')' if $has-default;
        $ret ~= * with $appendix;
        $ret;
    }

    method string(Str $s --> Str) {
        "'" ~ $s.subst(/(<[\\ ']>)/, { "\\$0" }, :g) ~ "'";
    }
    method boolean($b --> Str) { $b.Str.lc }
    method null-value(--> Str) { 'null' }

    method table-string(Str $t --> Str) {
        self.string('{{%' ~ $t ~ '}}');
    }
}

class Yii2Exporter is MigrationExporter is export {
    has Str:D      $.indent       is required;
    has            $.path         is required;
    has Str:D      $.class-prefix = 'm%y%m%d_%H%M%S_';
    has Int:D      $.dir-chmod    = 0o775;

    has DateTime $!time;

    submethod TWEAK() {
        my %formats = (
            '%' => ['%%'  , Nil],
            Y   => ['%04d', { .year       }],
            y   => ['%02d', { .year % 100 }],
            'm' => ['%02d', { .month      }],
            d   => ['%02d', { .day        }],
            H   => ['%02d', { .hour       }],
            M   => ['%02d', { .minute     }],
            'S' => ['%02d', { .second     }],
        );
        my @params-getters;
        my sub pass(Str:D $char) {
            with %formats{$char} {
                my ($placeholder, $getter) = @($_);
                @params-getters.push($getter)   with $getter;
                return $placeholder;
            }
            abort "unknown placholder `%{$char}`";
        }
        my Str $format = $!class-prefix.subst(/ '%' (.) /, { pass($0.Str) }, :g);

        $!time = DateTime.now(
            timezone  => 0,
            formatter => {
                sprintf $format, |@params-getters.map({ $^c(.self) });
            },
        );
    }

    method export(Yii2Migration:D $migration) {
        my Str:D $prefix = $!time.Str;
        $prefix.=subst(/ :i <-[ a..z \d / ]>+ /, '_', :g);
        $prefix.=subst(/ ^ '/'            /, '');
        $prefix.=subst(/   '/' <( '/'+ )> /, '', :g);
        $prefix.=subst(/   '/' $          /, '');

        my ($up, $down, @header) = do with $migration { .up, .down, |.header };

        my Str:D $ns-class = $prefix ~ $up.name.subst('-', '_', :g);
        my Str:D $class    = $ns-class.IO.basename;
        my Str:D $rel-file = $ns-class ~ ".php";

        my  $filename = $!path.add($rel-file);
        abort "file already exists - `$filename`" if $filename.e;

        given $filename.parent {
            when .e {
                .d or abort "path `{.self}` exists and is not a directory";
            }
            default {
                .mkdir($!dir-chmod);
            }
        }

        my $body = '';

        $body ~= "// $_".trim ~ "\n"    for @header.map({ .subst(/<?after '?'><?before '>'>/, ' ', :g) });
        $body ~= "\n"                   if  @header.elems;

        $body ~=
            "public function {$up.is-dml ?? 'safeUp' !! 'up' }()\n" ~
            "\{\n" ~
            $up.code.indent(4) ~ "\n" ~
            "}\n\n" ~
            "public function {$down.is-dml ?? 'safeDown' !! 'down'}()\n" ~
            "\{\n" ~
            $down.code.indent(4) ~ "\n" ~
            '}';

        my $code = '<?php' ~ "\n\n" ~ 'use yii\db\Migration;' ~ "\n\n" ~
            "class $class extends Migration\n" ~
            "\{\n" ~
            $body.indent(4) ~ "\n" ~
            "}\n";

        unless ' ' x 4 eq $migration.indent {
            $code.=subst(/^^(' ' ** 4)+/, { $!indent x $0.elems }, :g);
        }

        $filename.spurt($code, :createonly)
            or X::IO.new(pyload => "cannot create file - `$filename`");
        put "* $rel-file";

        $!time.=later(:5second);
    }
}
