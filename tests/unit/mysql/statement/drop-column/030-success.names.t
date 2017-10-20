---- IN ----
- %table\@name\+is\|strange . \#\~column\$name\* : int
---- OUT ----
$> drop_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - %table\@name\+is\|strange . \#\~column\$name\* : int
    UP:
        `drop_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange` DROP COLUMN `#~column$name*`;
        ⟩
    DOWN:
        `add_table_name_is_strange_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD COLUMN `#~column$name*` INT NOT NULL;
        ⟩
.
