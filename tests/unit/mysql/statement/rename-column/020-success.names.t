---- IN ----
* %table\@name\+is\|strange . \#\~column\$name\* => \!\(\)\[\]
---- OUT ----
$> rename_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table\@name\+is\|strange . \#\~column\$name\* => \!\(\)\[\]
    UP:
        `rename_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                CHANGE COLUMN `#~column$name*` `!()[]` /* same type definition here */;
        ⟩
    DOWN:
        `rename_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                CHANGE COLUMN `!()[]` `#~column$name*` /* same type definition here */;
        ⟩
.
