---- IN ----
+ U %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_idx-table_name_is_strange-_column_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + U %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD UNIQUE `idx-table@name+is|strange-#~column$name*` (`#~column$name*`);
        ⟩
    DOWN:
        `drop_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP UNIQUE `idx-table@name+is|strange-#~column$name*`;
        ⟩
.
