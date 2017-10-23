Lazy Migration Generator
========================

[![Build status](https://travis-ci.org/Vovan-VE/lazymgen.svg)](https://travis-ci.org/Vovan-VE/lazymgen)

Generate lots of migrations scripts just with a single stupid weird script.

What is this for?
-----------------

### The problem

Migrations should be atomic. Otherwise in case of some failure in the middle of
a transaction you will need either hack the migration temporary or manually
undo applied part of it.

MySQL 5 cannot execute a number of DDL statements in transaction. So when you
write multiple DDL for MySQL in a single migration, you _will_ hit the problem
above.

### Solution

So, you need a number of tiny DDL migrations. What if you need to refactor
database structure while it has many tables full of data? You probably will need
to create 10, 20, more migrations.

Here comes Lazy Migration Generator. Write a single script with weird but short
syntax full of stupit abbreviations/shortcuts. Feed the script to `lazymgen` and
it will generate migrations.


Install
-----

Currently there is no automated installation.

*   Directories `bin/` and sibling `src/` must be in the same parent directory.
*   File `bin/lazymgen` either must be available in `$PATH` directly or you can
    just make a symlink to it from any `$PATH` location.

Project requires [Perl 6][perl6] (6.c) interpretter available in `$PATH`.

If you are using [Rakudo][] and `src/` is not writeable mostly, make sure to run
`lazymgen` once by privileged user to let Rakudo to write precompiled cache (it
should appear under `src/`).

Usage
-----

Input script will be read from input.

```sh
# Debug conversion to output
$ lazymgen < examples/01-all.txt

# Generate Yii2 migrations (default path is ./migrations/)
$ lazymgen yii2 < examples/01-all.txt

# Generate Yii2 migrations in custom path
$ lazymgen --path=path/to/migrations yii2 < examples/01-all.txt

# See short usage hints
$ lazymgen --help

# More detailed help
$ lazymgen man
```


Script syntax
-------------

See [docs][].


Formats
-------

Currently there are still some limitations to be expanded.

*   Only Yii2 and MySQL format is supported to generate statements code.
*   Result can be either Yii2 migrations files or debug to STDOUT.


Examples
--------

See [examples][]. See also [tests][] as examples too.


Testing
-------

Tests are covered by [IO Tester][]. One is available as a Git submodule.

```sh
$ git submodule update --init
$ vendor/iotester/bin/iotester
```


License
-------

This project is under [MIT License][mit].


[docs]: docs/README.md
[examples]: examples/
[IO Tester]: https://github.com/Vovan-VE/iotester
[mit]: https://opensource.org/licenses/MIT
[perl6]: https://perl6.org/
[Rakudo]: http://rakudo.org/
[tests]: tests/unit/
