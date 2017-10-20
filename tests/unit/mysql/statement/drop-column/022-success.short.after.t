---- IN ----
- %table-name . column-name : int > another-column
---- OUT ----
$> drop_table-name_column-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - %table-name . column-name : int > another-column
    UP:
        `drop_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name` DROP COLUMN `column-name`;
        ⟩
    DOWN:
        `add_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD COLUMN `column-name` INT NOT NULL AFTER `another-column`;
        ⟩
.
