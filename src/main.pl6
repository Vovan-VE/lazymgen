use v6.c;

use App::Core;
use App::Parsing;
use App::Format::MySQL;
use App::Format::Yii2;

my constant $PROJECT_NAME = 'Lazy Migration Generator';
my constant $PROJECT_VER  = '0.1.0';
my constant $BIN_NAME     = 'lazymgen';

my \IS_I = INIT { $*IN.t && $*OUT.t };

class DebugExporter is MigrationExporter {
    has  $!to = $*OUT;

    method export(Migration:D $migration --> Bool) {
        $!to.say($migration);
    }
}

sub transform(:$input, TransformFormat :$format, MigrationExporter :$exporter) {
    put "$PROJECT_NAME ver. $PROJECT_VER"   if IS_I;
    put "Interactive mode"                  if IS_I;
    print '> '                              if IS_I;

    my @migrations;
    my Int $line_number = 0;

    # https://rt.perl.org/Public/Bug/Display.html?id=132076
    # last/next inside CATCH does not work ever - neither anonymouse nor labeled
    #
    # `IO::Handle.lines` reads input lazily. Label for the loop
    # could not be found - an exception cause some corruptions.
    #
    # So, here is `Bool $goto-next` to solve CATCH blocks.
    for $input.lines -> $line {
        NEXT {
            print '> '      if IS_I;
        }
        LAST {
            put '(EOF)'     if IS_I;
        }

        ++$line_number;
        next unless $line.trim;
        my $statement;
        my $goto-next = False;
        try {
            $statement = parse-statement($line);

            CATCH {
                when X::MatchFail {
                    if IS_I {
                        put "Syntax: $_";
                        # next;
                        $goto-next = True;
                    }
                    else {
                        abort "syntax: $_ - at line $line_number";
                    }
                }
                when X::Runtime {
                    if IS_I {
                        put "{.^name}: $_";
                        # next;
                        $goto-next = True;
                    }
                    else {
                        abort "{.^name}: $_ - at line $line_number";
                    }
                }
            }
        }
        next if $goto-next;
        unless $statement {
            if IS_I {
                put 'Syntax mismatch';
                next;
            }
            abort "cannot match at line $line_number\n";
        }

        next unless $statement.made<statement>;

        my $migration;
        try {
            $migration = {
                migration => $format.make-migration($statement, header => (
                    "Generated with $PROJECT_NAME",
                )),
                line      => $line_number,
            };

            CATCH {
                when X::Runtime {
                    if IS_I {
                        put "{.^name}: $_";
                        # next;
                        $goto-next = True;
                    }
                    else {
                        abort "{.^name}: $_ - at line $line_number";
                    }
                }
            }
        }
        next if $goto-next;

        if IS_I {
            try {
                $exporter.export($migration<migration>);
                CATCH {
                    when X::Runtime {
                        put "{.^name}: $_";
                        # next;
                        # nothing to skip
                    }
                }
            }
        }
        else {
            @migrations.push($migration);
        }
    }

    for @migrations -> $item {
        try {
            $exporter.export($item<migration>);
            CATCH {
                when X::Runtime {
                    abort "{.^name}: $_ - at line $item<line>";
                }
            }
        }
    }
}

my constant CODE_MYSQL = 'mysql';
my constant CODE_YII2  = 'yii2';

my constant DEFAULT_INDENT = ' ' x 4;

my %*SUB-MAIN-OPTS = (
    :named-anywhere,
);

multi sub MAIN('yii2', 'list-types') {
    .put for Yii2Format.data-types.sort;
}

multi sub MAIN('yii2',
    Str:D :$path         = './migrations',
    Str:D :$indent       = DEFAULT_INDENT,
    Str:D :$class-prefix = 'm%y%m%d_%H%M%S_',
    Str:D :$dir-chmod    = '775',
) {
    my $path_io = $path.IO;
    with $path_io {
        unless .e && .d {
            abort "given path either does not exist or is not a directory - {.self}";
        }
    }

    transform(
        input    => $*IN,
        format   => Yii2Format.new,
        exporter => Yii2Exporter.new(
            :path($path_io),
            :$indent,
            :$class-prefix,
            :dir-chmod(:8($dir-chmod))
        ),
    );
}

multi sub MAIN(
    Str:D :$code = CODE_YII2,
) {
    my %formats = (
        (CODE_MYSQL) => MySQL-Format,
        (CODE_YII2)  => Yii2Format,
    );

    %formats{$code}:exists  or abort("unknown code format '$code'");

    transform(
        input    => $*IN,
        format   => %formats{$code}.new,
        exporter => DebugExporter.new,
    );
}

sub get-usage() {
    Q:c:to/_END/;
    Usage:
        {$BIN_NAME} [<options>]

        {$BIN_NAME} yii2 [<options>]
        {$BIN_NAME} yii2 list-types

        {$BIN_NAME} man
    _END
}

multi sub MAIN('man') {
    print Q:c:to/_END/;
    {$PROJECT_NAME} v{$PROJECT_VER}

    {get-usage()}
    Description
        Generates migrations from short stupid weird script.

        Without arguments reads source script from the input and writes result
        in debug style to output. When both input and output are terminal then
        interactive mode will be enabled.

        `yii2` subset toggles Yii2 migrations to be generated into given directory.

    Options
        **default**

        --code=<type>
            Code type. Either 'mysql' or 'yii2'.

        **yii2**

        --class-prefix=<format>
            Format to generate path and filename prefix for migrations under
            the `--path` directory. Default format `m%y%m%d_%H%M%S_` will
            produce classes names like so:

                m170829_150305_create_user
                m170829_150310_add_idx_user_mail
                ...

            Supported placeholders from `date(1)` are: %Y %y %m %d %H %M %S.

            Format can contain `/` to create subdirectories.

        --dir-chmod=<mode>
            Permissions for subdirectories produced by `--class-prefix`
            with `/` in format. Octal number. Default is `775`.

        --indent=string
            One level indention string. Will be used literally in generated
            result. Default is four spaces.
            To use TAB follow instructions for you shell. For example in Bash
            you can use C-style string: $'\t' .

        --path=<path>
            Base path to store generated migrations. Path must to exist. Default
            is `./migrations` .

    _END
}

sub USAGE() {
    print get-usage();
}
