---- IN ----
- U %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_idx-table_name_is_strange-_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - U %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP UNIQUE `idx-table@name+is|strange-#~column$name*`;
        ⟩
    DOWN:
        `add_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD UNIQUE `idx-table@name+is|strange-#~column$name*` (`#~column$name*`);
        ⟩
.
