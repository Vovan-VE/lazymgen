unit module App::Parsing;

use App::Core;

class X::MatchFail is X::AdHoc is export {}
class X::Unsupported is X::Runtime {}

grammar MigrationSource {
    token ws { <!ww> \h* }

    token num-sign { <[- +]> }
    token num-int { 0 | <[1..9]> \d* }
    token num-frac { '.' \d+ }
    token num-exp { :i e <.num-sign>? \d+ }
    token number { <.num-sign>? <.num-int> <.num-frac>? <.num-exp>? }

    token string-content { [ <-[' \\]>+ | \\ . ]* }
    token string-content-with-end { <string-content> ~ \' <?> }
    token string { \' ~ <string-content-with-end> <?> }

    token value-keyword { :i << [ TRUE | FALSE | NULL ] >> }

    token name-word {
        :i
        <!before <[ - \d ]> >
        [ <[ _ a..z \d ]>+ | \\ . ]+
    }
    token name { <.name-word>+ % '-'+ }

    proto token value {*}
    token value:sym<string> { <string> }
    token value:sym<number> { <number> }
    token value:sym<value-keyword> { <value-keyword> }

    rule default-value { ['=' <!before '>'>] ~ <value> <?> }
    rule numbers-list { [<number> ]* % [',' ] }
    rule params-list { <numbers-list> ~ ')' <?> }
    rule params { '(' ~ <params-list> <?> }
    token null-mark { '?' }
    rule type {
        [':' ~ <name> <?>]
        <params>?
        <null-mark>?
        <default-value>?
    }

    rule column-definition { <name> ~ <type> <?> }

    rule column-definition-list { [<column-definition> ]+ % [',' ] }
    rule columns-definitions-end { <column-definition-list> ~ ')' <?> }
    rule create-table-body { '(' ~ <columns-definitions-end> <?> }

    proto rule position {*}
    rule position:sym<first> { '^' }
    rule position:sym<after> { '>' ~ <name> <?> }

    rule alter-column-type { <type> <position>? }

    token alias { '@' ~ <name> <?> }
    token table { '%' ~ <name> <?> }

    rule alter-column-type-to { <alter-column-type> ~ '=>' <?> }
    proto rule alter-column-type-new {*}
    rule alter-column-type-new:sym<full> { <name> <alter-column-type>? }
    rule alter-column-type-new:sym<type> { <alter-column-type> }
    proto rule alter-column-spec {*}
    rule alter-column-spec:sym<name> { '=>' ~ <name> <?> }
    rule alter-column-spec:sym<type> { <alter-column-type-to> ~ <alter-column-type-new> <?> }
    rule alter-column { <name> ~ <alter-column-spec> <?> }
    rule rename-table { '=>' ~ <table> <?> }

    rule names-list { [<name> ]+ % [',' ] }
    rule columns-ref-list-end { <names-list> ~ ')' <?> }
    proto rule columns-ref {*}
    rule columns-ref:<dot> { '.' ~ <name> <?> }
    rule columns-ref:<list> { '(' ~ <columns-ref-list-end> <?> }
    rule table-columns-ref { <table> ~ <columns-ref> <?> }

    proto token fk-verb {*}
    token fk-verb:sym<restrict> { '!' }
    token fk-verb:sym<cascade> { '>' }
    token fk-verb:sym<set-null> { '?' }
    token fk-on-delete { '~' ~ <fk-verb> <?> }
    token fk-on-update { '*' ~ <fk-verb> <?> }
    rule fk-target { '=>' ~ <table-columns-ref> <?> }
    rule fk-map { <table-columns-ref> ~ <fk-target> <?> }
    rule fk-spec { <alias>? ~ <fk-map> <?> }
    rule fk-statement {
        [:i<<FK>>] ~ <fk-spec> <?>
        [
            <fk-on-delete> <fk-on-update>?
            | <fk-on-update> <fk-on-delete>?
        ]?
    }

    token index-type { :i << [I | U | PK] >> }
    rule key-spec { <alias>? ~ <table-columns-ref> <?> }
    rule key-statement { <index-type> ~ <key-spec> <?> }

    rule add-column-spec { <name> ~ <alter-column-type> <?> }
    rule add-column-body { '.' ~ <add-column-spec> <?> }
    proto rule table-ddl-spec {*}
    rule table-ddl-spec:sym<create> { <create-table-body> }
    rule table-ddl-spec:sym<add-col> { <add-column-body> }
    rule table-ddl-statement { <table> ~ <table-ddl-spec> <?> }

    proto rule ddl-statement {*}
    rule ddl-statement:<table> { <table-ddl-statement> }
    rule ddl-statement:<key> { <key-statement> }
    rule ddl-statement:<fk> { <fk-statement> }

    rule create-statement { '+' ~ <ddl-statement> <?> }
    rule drop-statement { '-' ~ <ddl-statement> <?> }

    rule data-statement { '=' }

    proto rule alter-statement-spec {*}
    rule alter-statement-spec:sym<rename-table> { <rename-table> }
    rule alter-statement-spec:sym<alter-column> { '.' ~ <alter-column> <?> }
    rule alter-statement-body { <table> ~ <alter-statement-spec> <?> }
    rule alter-statement { '*' ~ <alter-statement-body> <?> }

    rule comment-line { '#' \N* }

    proto rule statement-body {*}
    rule statement-body:sym<create> { <create-statement> }
    rule statement-body:sym<drop> { <drop-statement> }
    rule statement-body:sym<alter> { <alter-statement> }
    rule statement-body:sym<data> { <data-statement> }
    rule statement-body:sym<comment> { <comment-line> }

    rule statement-start { ^^ ~ <statement-body> <?> }
    rule TOP { <statement-start> ~ $$ <?> }

    my %goal-display = (
        add-column-spec         => '<name>',
        alter-column            => '<name>',
        alter-column-spec       => '`:` or `=>`',
        alter-column-type       => '`:`',
        alter-column-type-new   => '<name> or `:`',
        alter-statement-body    => '<table>',
        alter-statement-spec    => '`.` or `=>`',
        columns-definitions-end => '<name>',
        columns-ref             => '`.` or `(`',
        columns-ref-list-end    => '<name>',
        ddl-statement           => '<table> , `PK` , `U` , `I` or `FK`',
        fk-map                  => '<table>',
        fk-target               => '`=>`',
        fk-verb                 => '`!` , `>` or `?`',
        # name                    => '',
        # table                   => '`%table`',
        table-columns-ref       => '<table>',
        table-ddl-spec          => '`(` or `.`',
        type                    => '`:`',
        # value                   => '',
    );

    method FAILGOAL($goal) {
        my constant CONTEXT = 20;
        my $expected = do given $goal.trim {
            when '$$'                               { 'EOL'  }
            when "\\'"                              { "<'>"  }
            when / \' ( <-[ ' \\ ]>+ ) \' /         { "`$0`" }
            when / '<' '.'? ( <[ a..z - ]>+ ) '>' / { %goal-display{$0} || .self }
            default                                 { .self  }
        }

        my $after = self.target.substr((self.pos - CONTEXT max 0) ..^ self.pos);
        $after = $after
            ?? ' after `' ~ (self.pos > CONTEXT ?? '...' !! '') ~ $after ~ '`'
            !! "";
        my $near = self.pos < self.target.chars
            ?? 'near `'
                ~ self.target.substr(self.pos, CONTEXT)
                ~ (self.pos < self.target.chars - CONTEXT ?? '...' !! '')
                ~ '`'
            !! 'instead of EOL';
        die X::MatchFail.new(
            payload => "expected {$expected}{$after} {$near} at position {self.pos}"
        );
    }
}

my constant POS_FIRST is export = 'first';
my constant POS_AFTER is export = 'after';

my constant ALTER_NAME = 'name';
my constant ALTER_TYPE = 'type';

my constant FK_RESTRICT is export = 'restrict';
my constant FK_CASCADE  is export = 'cascade';
my constant FK_SET_NULL is export = 'set-null';

my constant ST_CREATE_TABLE = 'create-table';
my constant ST_ADD_COLUMN   = 'add-column';
my constant ST_PRIMARY      = 'primary';
my constant ST_UNIQUE       = 'unique';
my constant ST_INDEX        = 'index';
my constant ST_FK           = 'foreign-key';
my constant ST_DATA         = 'data';
my constant ST_RENAME_TABLE = 'rename-table';
my constant ST_ALTER_COLUMN = 'alter-column';

class App::Number {
    has Str:D $.source is required;

    multi method gist(App::Number: --> Str) {
        "{self.^name}({$!source})";
    }
}

class MigrationSourceActions {
    my %keyword-value = (
        TRUE  => True,
        FALSE => False,
        NULL  => Nil,
    );
    my %key-type = (
        PK => ST_PRIMARY,
        U  => ST_UNIQUE,
        I  => ST_INDEX,
    );

    method !unescape ($str) { $str.subst(/ \\ (.) /, { $0 }, :g) }

    method number ($/) { make App::Number.new(source => $/.Str) }

    method string-content ($/) { make self!unescape($/.Str) }
    method string-content-with-end ($/) { make $<string-content>.made }
    method string ($/) { make $<string-content-with-end>.made }

    method value-keyword ($/) { make $/.Str.uc }

    method name ($/) { make self!unescape($/.Str) }

    method value:sym<string> ($/) { make $<string>.made }
    method value:sym<number> ($/) { make $<number>.made }
    method value:sym<value-keyword> ($/) { make %keyword-value{$<value-keyword>.made} }

    method default-value ($/) { make $<value>.made }
    method numbers-list ($/) { make $<number>».made }
    method params-list ($/) { make $<numbers-list>.made }
    method params ($/) { make $<params-list>.made }
    method type ($/) {
        make {
            name          => $<name>.made,
            params        => $<params>.made // [],
            null          => $<null-mark>.Bool,
            default       => $<default-value>.Bool,
            default-value => $<default-value>.made,
        };
    }

    method column-definition ($/) {
        make {
            name => $<name>.made,
            type => $<type>.made,
        };
    }

    method column-definition-list ($/) { make $<column-definition>».made }
    method columns-definitions-end ($/) { make $<column-definition-list>.made }
    method create-table-body ($/) { make $<columns-definitions-end>.made }

    method position:sym<first> ($/) { make {pos => POS_FIRST} }
    method position:sym<after> ($/) { make {pos => POS_AFTER, name => $<name>.made} }

    method alter-column-type ($/) {
        make {
            type     => $<type>.made,
            position => $<position>.made,
        }
    }

    method alias ($/) { make $<name>.made }
    method table ($/) { make $<name>.made }

    method alter-column-type-to ($/) { make $<alter-column-type>.made }
    method alter-column-type-new:sym<full> ($/) {
        make {
            name => $<name>.made,
            type => $<alter-column-type>.made,
        }
    }
    method alter-column-type-new:sym<type> ($/) {
        make {
            type => $<alter-column-type>.made,
        }
    }
    method alter-column-spec:sym<name> ($/) {
        make {
            alt => ALTER_NAME,
            to  => $<name>.made,
        };
    }
    method alter-column-spec:sym<type> ($/) {
        my ($to-name, $to-type) = $<alter-column-type-new>.made<name type>;
        make {
            alt  => ALTER_TYPE,
            from => $<alter-column-type-to>.made,
            to-name => $to-name,
            to-type => $to-type,
        };
    }
    method alter-column ($/) {
        make {
            name => $<name>.made,
            $<alter-column-spec>.made.kv,
        };
    }
    method rename-table ($/) { make $<table>.made }

    method names-list ($/) { make $<name>».made }
    method columns-ref-list-end ($/) { make $<names-list>.made }
    method columns-ref:<dot> ($/) { make [$<name>.made] }
    method columns-ref:<list> ($/) { make $<columns-ref-list-end>.made }
    method table-columns-ref ($/) {
        make {
            table   => $<table>.made,
            columns => $<columns-ref>.made,
        };
    }

    method fk-verb:sym<restrict> ($/) { make FK_RESTRICT }
    method fk-verb:sym<cascade> ($/)  { make FK_CASCADE  }
    method fk-verb:sym<set-null> ($/) { make FK_SET_NULL }
    method fk-on-delete ($/) { make { delete => $<fk-verb>.made } }
    method fk-on-update ($/) { make { update => $<fk-verb>.made } }
    method fk-target ($/) { make $<table-columns-ref>.made }
    method fk-map ($/) {
        make {
            child  => $<table-columns-ref>.made,
            parent => $<fk-target>.made,
        };
    }
    method fk-spec ($/) {
        make {
            alias => $<alias>.made,
            $<fk-map>.made.kv,
        };
    }
    method fk-statement ($/) {
        make {
            delete => FK_RESTRICT,
            update => FK_RESTRICT,
            $<fk-spec>.made.kv,
            $<fk-on-delete>.made.kv,
            $<fk-on-update>.made.kv,
        };
    }

    method index-type ($/) { make %key-type{$/.Str.uc} }
    method key-spec ($/) {
        make {
            alias => $<alias>.made,
            $<table-columns-ref>.made.kv,
        };
    }
    method key-statement ($/) {
        make {
            statement => $<index-type>.made,
            $<key-spec>.made.kv,
        };
    }

    method add-column-spec ($/) {
        make {
            name => $<name>.made,
            $<alter-column-type>.made.kv,
        };
    }
    method add-column-body ($/) { make $<add-column-spec>.made }
    method table-ddl-spec:sym<create> ($/) {
        make {
            statement => ST_CREATE_TABLE,
            columns   => $<create-table-body>.made,
        };
    }
    method table-ddl-spec:sym<add-col> ($/) {
        make {
            statement => ST_ADD_COLUMN,
            $<add-column-body>.made.kv,
        };
    }
    method table-ddl-statement ($/) {
        make {
            table => $<table>.made,
            $<table-ddl-spec>.made.kv,
        };
    }

    method ddl-statement:<table> ($/) { make $<table-ddl-statement>.made }
    method ddl-statement:<key> ($/) { make $<key-statement>.made }
    method ddl-statement:<fk> ($/) {
        make {
            statement => ST_FK,
            $<fk-statement>.made.kv,
        };
    }

    method create-statement ($/) {
        make {
            create => True,
            $<ddl-statement>.made.kv,
        };
    }
    method drop-statement ($/) {
        make {
            drop => True,
            $<ddl-statement>.made.kv,
        };
    }

    method data-statement ($/) { make { statement => ST_DATA } }

    method alter-statement-spec:sym<rename-table> ($/) {
        make {
            statement => ST_RENAME_TABLE,
            to   => $<rename-table>.made,
        };
    }
    method alter-statement-spec:sym<alter-column> ($/) {
        make {
            statement => ST_ALTER_COLUMN,
            $<alter-column>.made.kv,
        };
    }
    method alter-statement-body ($/) {
        make {
            table => $<table>.made,
            $<alter-statement-spec>.made.kv,
        };
    }
    method alter-statement ($/) { make $<alter-statement-body>.made }

    method comment-line ($/) { make { statement => Nil } }

    method statement-body:sym<create>  ($/) { make $<create-statement>.made }
    method statement-body:sym<drop>    ($/) { make $<drop-statement>.made }
    method statement-body:sym<alter>   ($/) { make $<alter-statement>.made }
    method statement-body:sym<data>    ($/) { make $<data-statement>.made }
    method statement-body:sym<comment> ($/) { make $<comment-line>.made }

    method statement-start ($/) { make $<statement-body>.made }
    method TOP ($/) { make $<statement-start>.made }
}

sub parse-statement(Str:D $line) is export {
    MigrationSource.parse($line, actions => MigrationSourceActions)
}

class Statement is export {
    has Str:D  $.name   = '';
    has Str:D  $.code   = '';
    has Bool:D $.is-dml = False;

    submethod TWEAK() {
        $!name = self.filter-name($!name);
    }

    multi method gist(Statement: --> Str) {
        "`$!name` is-dml={$!is-dml} ⟨\n" ~
        $!code.indent(4) ~ "\n" ~
        "⟩";
    }

    method filter-name(Str:D $name --> Str:D) { $name }
}

class Migration is export {
    has Match:D     $.source is required;
    has Str:D       @.header;
    has Statement:D $.up     is required;
    has Statement:D $.down   is required;

    multi method gist(Migration: --> Str) {
        '$> ' ~ self.up.name ~ "\n" ~
        @!header.map({
            "> $_".trim.indent(4) ~ "\n"
        }).join ~
        (UP => self.up, DOWN => self.down).map({
            (
                .key ~ ":\n" ~
                .value.gist.indent(4)
            ).indent(4) ~ "\n"
        }).join ~
        '.';
    }
}

class TransformFormat is export {
    # Export matched statement to complete migration code
    method make-migration(Match:D $s, :@header --> Migration) {
        self.migration-class.new(
            source => $s,
            header => (|@header, |self.init-header($s)),
            up     => self.statement($s),
            down   => self.statement($s, :back),
        );
    }

    method migration-class(--> Migration:U) { Migration }

    method init-header(Match:D $source) {
        (
            "Source:",
            "    {$source.Str.trim}",
        );
    }

    method create-table($s --> Statement) {...}
    method drop-table  ($s --> Statement) {...}

    method add-column ($s --> Statement) {...}
    method drop-column($s --> Statement) {...}

    method add-primary-key ($s --> Statement) {...}
    method drop-primary-key($s --> Statement) {...}

    method add-unique-key ($s --> Statement) {...}
    method drop-unique-key($s --> Statement) {...}

    method add-index ($s --> Statement) {...}
    method drop-index($s --> Statement) {...}

    method add-foreigh-key ($s, Bool:D :$back = False --> Statement) {...}
    method drop-foreign-key($s, Bool:D :$back = False --> Statement) {...}

    method rename-table($s, Bool:D :$back = False --> Statement) {...}

    method alter-column-name($s, Bool:D :$back = False --> Statement) {...}
    method alter-column-type($s, Bool:D :$back = False --> Statement) {...}

    method data-statement($s, Bool:D :$back = False --> Statement) {...}

    method statement(Match:D $s, Bool:D :$back = False --> Statement) {
        my $m = $s.made;
        given $m<statement> {
            when ST_CREATE_TABLE {
                return self.drop-table($m)          if $back ?^ $m<drop>;
                return self.create-table($m);
            }
            when ST_ADD_COLUMN {
                return self.drop-column($m)         if $back ?^ $m<drop>;
                return self.add-column($m);
            }
            when ST_PRIMARY {
                return self.drop-primary-key($m)    if $back ?^ $m<drop>;
                return self.add-primary-key($m);
            }
            when ST_UNIQUE {
                return self.drop-unique-key($m)     if $back ?^ $m<drop>;
                return self.add-unique-key($m);
            }
            when ST_INDEX {
                return self.drop-index($m)          if $back ?^ $m<drop>;
                return self.add-index($m);
            }
            when ST_FK {
                return self.drop-foreign-key($m)    if $back ?^ $m<drop>;
                return self.add-foreigh-key($m);
            }
            when ST_RENAME_TABLE {
                return self.rename-table($m, :$back);
            }
            when ST_ALTER_COLUMN {
                return self.alter-column-name($m, :$back)   if ALTER_NAME eq $m<alt>;
                return self.alter-column-type($m, :$back);
            }
            when ST_DATA {
                return self.data-statement($m, :$back);
            }
            default {
                die "expected statement type `{.self}`";
            }
        }
    }

    method max-index-length(--> Int) { 64 }
    method index-name(Str $prefix, $alias, *@table-col-refs --> Str) {
        with $alias {
            .return if .chars <= self.max-index-length;
            self.throw-unsupported("too long index name given with alias");
        }

        my @tables;
        my @columns;
        # note @table-col-refs;
        for @table-col-refs {
            # $*ERR.say($(:TABLE($_<table>), :COLUMNS($_<columns>)));
            push |.list for @tables, @columns Z $_<table>, $_<columns>;
        }
        # note $(:@tables, :@columns);
        # note $(:@tables, :@columns).perl;

        my @refs = (@tables Z @columns».list).flat;
        # note $(@refs).perl;

        while @refs {
            with ($prefix, @refs).flat.join('-') {
                .return if .chars <= self.max-index-length;
            }
            @refs.pop;
        }
        self.throw-unsupported("too long index name in any case");
    }

    method default-value($value --> Str) {
        given $value {
            when Bool {
                return self.boolean(.self);
            }
            when App::Number {
                return self.number(.self.source);
            }
            when Str {
                return self.string(.self);
            }
            when Any:U {
                return self.null-value;
            }
            default {
                die "unexpected data type {.WHAT}";
            }
        }
    }

    method string($s --> Str) { $s }
    method number($n --> Str) { $n }
    method boolean($b --> Str) { ~$b }
    method null-value(--> Str) { 'NULL' }

    method throw-unsupported(Str:D $message) {
        die X::Unsupported.new(payload => $message);
    }
}

class MigrationExporter is export {
    method export(Migration:D $migration --> Bool) { ... }
}
