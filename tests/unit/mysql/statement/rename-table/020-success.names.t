---- IN ----
* %table\@name\+is\|strange => %\#\~table\$name\*
---- OUT ----
$> rename_table_name_is_strange_table_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table\@name\+is\|strange => %\#\~table\$name\*
    UP:
        `rename_table_name_is_strange_table_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                RENAME TO `#~table$name*`;
        ⟩
    DOWN:
        `rename_table_name_table_name_is_strange` is-dml=False ⟨
            ALTER TABLE `#~table$name*`
                RENAME TO `table@name+is|strange`;
        ⟩
.
