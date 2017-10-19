---- IN ----
+ %table-name . column-name : integer > another-column
---- OUT ----
$> add_table-name_column-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table-name . column-name : integer > another-column
    UP:
        `add_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD COLUMN `column-name` INTEGER NOT NULL AFTER `another-column`;

        ⟩
    DOWN:
        `drop_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name` DROP COLUMN `column-name`;
        ⟩
.
