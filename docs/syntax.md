Script Syntax
=============

One **statement** goes in separate line. Whitespaces are ignored. Empty lines
are ignored.

**Comment** lines are started with `#`. Comment can only occupy a whole line
ignoring leading whitespaces.

**Identifiers** are used for table, columns and data type names. Identifiers are
very close to CSS identifiers. It may contain latin letters, digits, underscores
and dashes literally. First symbol cannot be digit or dash. Dash also cannot be
the last symbol. Also any symbol can be escaped with `\` and so be used anywhere
in an identifier same as a letter. Examples: `foo42`, `lorem-ipsum`, `x\.y\.z`,
`\--foo-\-`.

See also [examples](../examples/) directory.


Statements
----------

Each statement produce one atomic migration.

_Note:_ Whitespaces are optional and can be inserted almost anywhere.


#### CREATE TABLE

```
+ %table-name (foo : data-type(42,37)? = 'default', bar : data-type)
```

Explanation:

Input code | Description
---------- | -----------
`+` | CREATE
`%table-name` | Table `table-name`
`(` ... `)` | Columns definitions list, separated by comma

Column definition:

Input code | Description
---------- | -----------
`foo` | Name
`: data-type` | Data type. Exact data types depends on format
`(42,37)` | Optional. Type parameters. Empty paranses are allowed too.
`?` | Optional. NULL-able sign. Absens means `NOT NULL`.
`= 'default'` | Optional. Default value.

Default value can be either number (`42`, `+1.2`, `1e3`, `-1.2e-3`), string (`''`, `'foo\'bar\\lol'`), `TRUE`, `FALSE` or `NULL`.

#### DROP TABLE

Same as CREATE TABLE but begins with `-` instead of `+`:

```
- %table-name (foo : data-type)
```

Complete table definition is required in order to generate backward side of
migration.

#### ADD COLUMN

```
+ %table . column-name : data-type (42)
+ %table . column-name : data-type ()   ^
+ %table . column-name : data-type      > after-column
```

Explanation:

Input code | Description
---------- | -----------
`+` | CREATE
`%table-name` | in table `table-name`
`.` | separate table and following column
`column-name : data-type (42)` | column definition same as in CREATE TABLE above
`^` | Optional. Let column be FIRST.
`> after-column` | Optional. Let column be after existing `after-column`

#### DROP COLUMN

Same as ADD COLUMN but begins with `-` instead of `+`:

```
- %table . column-name : data-type (42)
- %table . column-name : data-type ()   ^
- %table . column-name : data-type      > after-column
```

Complete column definition is required in order to generate backward side of
migration.

#### ADD PRIMARY KEY

```
+ PK %table-name . column-name
+ PK @key-name %table-name . column-name
+ PK @key-name %table-name ( column-name )
+ PK @key-name %table-name ( column1-name , column2-name )
```

You already seen almost everything above. New here is:

Input code | Description
---------- | -----------
`@key-name` | Optional. Name for the key.

When `@key-name` is omited it will be generated from table and column(s) names
like `pk-table-column1-column2`.

#### DROP PRIMARY KEY

```
- PK %table-name . column-name
- PK @key-name %table-name . column-name
- PK @key-name %table-name ( column-name )
- PK @key-name %table-name ( column1-name , column2-name )
```

#### ADD UNIQUE KEY

Same as ADD PRIMARY KEY but with `U` instead of `PK`:

```
+ U %table-name . column-name
+ U @key-name %table-name . column-name
+ U @key-name %table-name ( column-name )
+ U @key-name %table-name ( column1-name , column2-name )
```

Default key name prefixed with `idx`.

#### DROP UNIQUE KEY

```
- U %table-name . column-name
- U @key-name %table-name . column-name
- U @key-name %table-name ( column-name )
- U @key-name %table-name ( column1-name , column2-name )
```

#### ADD INDEX

Same as ADD PRIMARY KEY but with `I` instead of `PK`:

```
+ I %table-name . column-name
+ I @index-name %table-name . column-name
+ I @index-name %table-name ( column-name )
+ I @index-name %table-name ( column1-name , column2-name )
```

Default key name prefixed with `idx`.

#### DROP INDEX

```
- I %table-name . column-name
- I @index-name %table-name . column-name
- I @index-name %table-name ( column-name )
- I @index-name %table-name ( column1-name , column2-name )
```

#### ADD FOREIGN KEY

```
+ FK %child-table . foo         => %parent-table . foo
+ FK %child-table . foo         => %parent-table . foo     ~! *!
+ FK %child-table ( foo )       => %parent-table ( foo )   ~> *>
+ FK %child-table ( foo , bar ) => %parent-table ( a , b ) ~? *?
+ FK @key-name %child-table . ref-column => %parent-table . column
```

Mostly everithing is familar for you. New here are:

Input code | Description
---------- | -----------
`=>` | Separate child and parent tables and columns

Also here are optional phases actions:

.           | `RESTRICT` | `CASCADE` | `SET NULL`
----------- | ---------- | --------- | ----------
`ON DELETE` | `~!`       | `~>`      | `~?`
`ON UPDATE` | `*!`       | `*>`      | `*?`

_Note:_ Single column syntax `. column` and `( column )` means the same thing
and does not require to be the same style on the both sides of `=>`.

_Note:_ ON DELETE and ON UPDATE both are optional independently and can appear
in any order. In case of absens it means `RESTRICT`.

#### DROP FOREIGN KEY

Same is ADD FOREIGN KEY but with `-` instear of `+`.

```
- FK %child-table . foo         => %parent-table . foo
- FK %child-table . foo         => %parent-table . foo     ~! *!
- FK %child-table ( foo )       => %parent-table ( foo )   ~> *>
- FK %child-table ( foo , bar ) => %parent-table ( a , b ) ~? *?
- FK @key-name %child-table . ref-column => %parent-table . column
```

#### RENAME TABLE

```
* %old-table-name => %new-table-name
```

Nothing special here but ALTER sign `*` in front.

#### RENAME COLUMN

```
* %table . old-name => new-name
```

#### CHANGE COLUMN

Change both name and type

```
* %table . old-name :old-type ^ => new-name :new-type > bar
```

Change name, keep same type

```
* %table . old-name :type ^ => new-name
```

Change type, keep same name

```
* %table . column :old-type            => :new-type
* %table . column :old-type(42)? = 0 ^ => :new-type(37)? = 1 > bar
```

Both old and new column types are the same as in ADD COLUMN statement, t.i.
with optional parameters, NULL-able sign, default value and placement part
(first or after).

When changing both name and type, if both types and positions are exactly the
same, the statement means column rename.

Changing name keeping type is usefull i.e. for MySQL which cannot just rename
column without its type.

#### DML stub

Currently there is no support for specific DML operations. Here is only a stub
statement just to generate empty migration. The statement is:

```
=
```
