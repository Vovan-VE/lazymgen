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


Usage
-----

Project requires [Perl 6][perl6] (6.c) interpretter available in `$PATH`.

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
```


Script syntax
-------------

See [docs](./docs/syntax.md).


Formats
-------

Currently there are still some limitations to be expanded.

*   Only Yii2 format is supported to generate statements code.
*   Result can be either Yii2 migrations files or debug to STDOUT.


Examples
--------

See [examples](./examples/).


Testing
-------

To run tests first [IO Tester][] is required. Just run it in project directory.

```sh
$ iotester
```

If IO Tester is not available in $PATH, use one from Git submodule:

```sh
$ git submodule update --init
$ tests/iotester/bin/iotester
```


License
-------

This project is under [MIT License][mit].


[mit]: https://opensource.org/licenses/MIT
[perl6]: https://perl6.org/
[IO Tester]: https://github.com/Vovan-VE/iotester
