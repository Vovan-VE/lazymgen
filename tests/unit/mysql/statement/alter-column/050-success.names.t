---- IN ----
* %table\@name\+is\|strange . \#\~column\$name\* : integer > \$\%t\; => : integer > \ \ \.
---- OUT ----
$> alter_table_name_is_strange_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table\@name\+is\|strange . \#\~column\$name\* : integer > \$\%t\; => : integer > \ \ \.
    UP:
        `alter_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                CHANGE COLUMN `#~column$name*` `#~column$name*` INTEGER NOT NULL AFTER `  .`;
        ⟩
    DOWN:
        `alter_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                CHANGE COLUMN `#~column$name*` `#~column$name*` INTEGER NOT NULL AFTER `$%t;`;
        ⟩
.
