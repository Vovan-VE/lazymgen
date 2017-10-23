MySQL data types
----------------

Type name for MySQL code generator is constructed like so:

```
type-tag-tag...
```

Here `type` is any of MySQL true data types name as is. No conversion or
replacement will be performed.

Next `-tag`s are optional. Tags may be written in any order. Available tags are:

Tag  | Description
---- | -----------
`u`  | Adds `UNSIGNED`
`ai` | Adds `AUTO_INCREMENT`
`pk` | Adds `PRIMARY KEY`

Examples:

Code | Result
---- | ------
`int`             | `INT NOT NULL`
`int-u`           | `INT UNSIGNED NOT NULL`
`int-u()`         | `INT UNSIGNED NOT NULL`
`int-u(10)`       | `INT(10) UNSIGNED NOT NULL`
`int-u(10)?`      | `INT(10) UNSIGNED`
`int-u-ai-pk(10)` | `INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY`
