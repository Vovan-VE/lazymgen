unit module App::Format::MySQL;

use App::Core;
use App::Parsing;

class MySQL-Statement is Statement is export {
    method filter-name(Str:D $name --> Str:D) {
        $name
            .subst(/ :i <-[ a..z \d - ]>+ /, '_', :g)
            .subst(/ ^ _+ || _+ $ /, '', :g)
            || 'noname';
    }
}

class MySQL-Migration is Migration is export {
    has Str:D $.indent = '';
}

class MySQL-Format is TransformFormat is export {
    my constant FK_ACTION = {
        (FK_RESTRICT) => 'RESTRICT',
        (FK_CASCADE)  => 'CASCADE',
        (FK_SET_NULL) => 'SET NULL',
    };

    my constant S_FK = 'fk';
    my constant S_PK = 'pk';
    my constant S_IDX = 'idx';

    method migration-class(--> Migration:U) { MySQL-Migration }

    method init-header(Match:D $source) {
        (
            "Format: MySQL",
            "",
            |callsame,
        );
    }

    method create-table($s --> MySQL-Statement) {
        my ($table, $columns) = $s<table columns>;
        MySQL-Statement.new(
            :name("create_{$table}"),
            :code(
                'CREATE TABLE ' ~ self.name($table) ~ " (\n" ~
                @($columns).map({
                    my ($name, $type) = .<name type>;
                    self.name($name) ~ ' ' ~ self.column-type($type);
                }).join(",\n").indent(4) ~ "\n" ~
                ') CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=InnoDB;'
            ),
        );
    }
    method drop-table($s --> MySQL-Statement) {
        my ($table) = $s<table>;
        MySQL-Statement.new(
            :name("drop_{$table}"),
            :code('DROP TABLE ' ~ self.name($table) ~ ';')
        );
    }

    method add-column($s --> MySQL-Statement) {
        my ($table, $column, $type, $pos) = $s<table name type position>;
        MySQL-Statement.new(
            :name("add_{$table}_{$column}"),
            :code(
                'ALTER TABLE ' ~ self.name($table) ~ "\n" ~
                (
                    'ADD COLUMN ' ~ self.name($column) ~ ' ' ~
                    self.column-type-pos($type, $pos)
                ).indent(4) ~ ";\n"
            )
        );
    }
    method drop-column($s --> MySQL-Statement) {
        my ($table, $column) = $s<table name>;
        MySQL-Statement.new(
            :name("drop_{$table}_{$column}"),
            :code(
                'ALTER TABLE ' ~ self.name($table) ~ ' ' ~
                'DROP COLUMN ' ~ self.name($column) ~ ';'
            )
        );
    }

    method add-primary-key($s --> MySQL-Statement) {
        self!index-common($s, 'PRIMARY KEY', S_PK, :add, :!add-name, :cols);
    }
    method drop-primary-key($s --> MySQL-Statement) {
        self!index-common($s, 'PRIMARY KEY', S_PK, :!add, :!add-name);
    }

    method add-unique-key($s --> MySQL-Statement) {
        self!index-common($s, 'UNIQUE', S_IDX, :add, :cols);
    }
    method drop-unique-key($s --> MySQL-Statement) {
        self!index-common($s, 'UNIQUE', S_IDX, :!add);
    }

    method add-index($s --> MySQL-Statement) {
        self!index-common($s, 'INDEX', S_IDX, :add, :cols);
    }
    method drop-index($s --> MySQL-Statement) {
        self!index-common($s, 'INDEX', S_IDX, :!add);
    }

    method !index-common($s, Str $what, Str $prefix, Bool:D :$add, Bool:D :$add-name = True, Bool:D :$cols = False --> MySQL-Statement) {
        my ($alias, $table, $columns) = $s<alias table columns>;
        my $index_name = self.index-name($prefix, $alias, $s);
        MySQL-Statement.new(
            :name(($add ?? 'add' !! 'drop') ~ '_' ~ $index_name),
            :code(
                'ALTER TABLE ' ~ self.name($table) ~ "\n" ~
                (
                    ($add ?? 'ADD' !! 'DROP') ~ " $what" ~
                    ($add-name ?? ' ' ~ self.name($index_name) !! '') ~
                    ($cols
                        ?? ' (' ~ @$columns.map({ self.name($_) }).join(', ') ~ ')'
                        !! ''
                    ) ~
                    ';'
                ).indent(4)
            )
        );
    }

    method add-foreigh-key($s, Bool:D :$back = False --> MySQL-Statement) {
        my ($a, $f, $t, $d, $u) = $s<alias child parent delete update>;
        ($f, $t) = $t, $f if $back;
        my $index_name = self.index-name(S_FK, $a, $f, $t);
        MySQL-Statement.new(
            :name("add_$index_name"),
            :code(
                'ALTER TABLE ' ~ self.name($f<table>) ~ "\n" ~
                (
                    'ADD CONSTRAINT ' ~ self.name($index_name) ~ "\n" ~
                    'FOREIGN KEY (' ~ @($f<columns>).map({ self.name($_) }).join(', ') ~ ")\n" ~
                    'REFERENCES ' ~ self.name($t<table>) ~ ' (' ~
                    @($t<columns>).map({ self.name($_) }).join(', ') ~
                    ")\n" ~
                    'ON DELETE ' ~ FK_ACTION{$d} ~ "\n" ~
                    'ON UPDATE ' ~ FK_ACTION{$u}
                ).indent(4) ~ ';'
            )
        );
    }
    method drop-foreign-key($s, Bool:D :$back = False --> MySQL-Statement) {
        my ($a, $f, $t) = $s<alias child parent>;
        ($f, $t) = $t, $f if $back;
        my $index_name = self.index-name(S_FK, $a, $f, $t);
        MySQL-Statement.new(
            :name("drop_$index_name"),
            :code(
                'ALTER TABLE ' ~ self.name($f<table>) ~ "\n" ~
                (
                    'DROP FOREIGN KEY ' ~ self.name($index_name) ~ ';'
                ).indent(4)
            )
        );
    }

    method rename-table($s, Bool:D :$back = False --> MySQL-Statement) {
        my ($from_table, $to_table) = $s<table to>;
        ($from_table, $to_table) = $to_table, $from_table if $back;
        MySQL-Statement.new(
            :name("rename_{$from_table}_{$to_table}"),
            :code(
                'ALTER TABLE ' ~ self.name($from_table) ~ "\n" ~
                (
                    'RENAME TO ' ~ self.name($to_table) ~ ';'
                ).indent(4)
            )
        );
    }

    method alter-column-name($s, Bool:D :$back = False --> MySQL-Statement) {
        my ($table, $from_name, $to_name) = $s<table name to>;
        ($from_name, $to_name) = $to_name, $from_name if $back;
        MySQL-Statement.new(
            :name("rename_{$table}_{$from_name}_{$to_name}"),
            :code(
                'ALTER TABLE ' ~ self.name($table) ~ "\n" ~
                (
                    'CHANGE COLUMN ' ~ self.name($from_name) ~ ' ' ~
                    self.name($to_name) ~ ' /* same type definition here */;'
                ).indent(4)
            )
        );
    }
    method alter-column-type($s, Bool:D :$back = False --> MySQL-Statement) {
        my ($table, $name) = $s<table name>;
        my ($type, $pos) = ($back ?? $s<from> !! $s<to>)<type position>;
        MySQL-Statement.new(
            :name("alter_{$table}_$name"),
            :code(
                'ALTER TABLE ' ~ self.name($table) ~ "\n" ~
                (
                    'CHANGE COLUMN ' ~ self.name($name) ~ ' ' ~
                    self.name($name) ~ ' ' ~ self.column-type-pos($type, $pos)
                ).indent(4) ~ ';'
            )
        );
    }

    method data-statement($s, Bool:D :$back = False --> MySQL-Statement) {
        MySQL-Statement.new(
            :name('update')
            :code(
                '-- TODO: ' ~
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
        return $type ~ ' FIRST' if POS_FIRST eq $pos<pos>;
        return $type ~ ' AFTER ' ~ self.name($pos<name>);
    }

    method column-type($t --> Str) {
        my ($name, $params, $null, $has-default, $default) = $t<name params null default default-value>;
        my $params-joined = @($params)».source.join(', ');

        my $unsigned = False;
        my $primary  = False;
        my $autoinc  = False;
        with $name.split('-', :skip-empty).Array {
            while .elems > 1 {
                given .[*-1] {
                    when 'pk' { $primary  = True }
                    when 'ai' { $autoinc  = True }
                    when 'u'  { $unsigned = True }
                }
                .pop;
            }
            $name = .[0];
        }

        my $ret = $name.uc;
        $ret ~= '(' ~ $params-joined ~ ')'                  if $params-joined;
        $ret ~= ' UNSIGNED'                                 if $unsigned;
        if $primary {
            self.throw-unsupported('PRIMARY cannot be NULL') if $null;
        }
        else {
            $ret ~= ' NOT NULL'     unless $null;
        }
        $ret ~= ' DEFAULT ' ~ self.default-value($default)  if $has-default;
        $ret ~= ' AUTO_INCREMENT'                           if $autoinc;
        $ret ~= ' PRIMARY KEY'                              if $primary;
        $ret;
    }

    method string(Str $s --> Str) {
        "'" ~ $s.subst(/(<[\\ ']>)/, { "\\$0" }, :g) ~ "'";
    }
    method boolean($b --> Str) { $b.Str.uc }
    method null-value(--> Str) { 'NULL' }

    method name(Str:D $n --> Str:D) { '`' ~ $n.subst('`', '``', :g)  ~ '`' }
}
