---- IN ----
+ %table\@name--\+is\|--strange . \#\~new--column\$name\* : integer
---- OUT ----
$> add_table_name--_is_--strange_new--column_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table\@name--\+is\|--strange . \#\~new--column\$name\* : integer
    UP:
        `add_table_name--_is_--strange_new--column_name` is-dml=False ⟨
            ALTER TABLE `table@name--+is|--strange`
                ADD COLUMN `#~new--column$name*` INTEGER NOT NULL;

        ⟩
    DOWN:
        `drop_table_name--_is_--strange_new--column_name` is-dml=False ⟨
            ALTER TABLE `table@name--+is|--strange` DROP COLUMN `#~new--column$name*`;
        ⟩
.
