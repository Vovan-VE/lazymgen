---- IN ----
+ I %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_idx-table_name_is_strange-_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + I %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD INDEX `idx-table@name+is|strange-#~column$name*` (`#~column$name*`);
        ⟩
    DOWN:
        `drop_idx-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP INDEX `idx-table@name+is|strange-#~column$name*`;
        ⟩
.
