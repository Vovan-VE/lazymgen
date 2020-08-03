---- IN ----
+ %table-name . column-name : integer
---- OUT ----
$> add_table-name_column-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table-name . column-name : integer
    UP:
        `add_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD COLUMN `column-name` INTEGER NOT NULL;
        ⟩
    DOWN:
        `drop_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name` DROP COLUMN `column-name`;
        ⟩
.
