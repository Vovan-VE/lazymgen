TODO
====

*   `"\t".indent(1)` is `"\t "` but not `" \t"`. Refactor indention building
    to apply custom indention in the very end.
    So currently `indent => "\t"` produce broken indention.
    +1 to opinion that TAB is an evil.

*   Improve interactive mode: show syntax error and continue.

*   Add boolean flag for DML migrations.

*   Refactor grammar in altering column type to remove parallel branches `=>`
    and `= default`.

*   Tests.

*   Yii2: pattern for path like `path/%{year}/` and class/filename prefix like
    `m%{date}_%{time}`.

*   Make syntax error messager more readable.
