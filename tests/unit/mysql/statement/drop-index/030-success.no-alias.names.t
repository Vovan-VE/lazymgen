---- IN ----
- I %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_idx-table_name_is_strange-_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - I %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP INDEX `idx-table@name+is|strange-#~column$name*`;
        ⟩
    DOWN:
        `add_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD INDEX `idx-table@name+is|strange-#~column$name*` (`#~column$name*`);
        ⟩
.
