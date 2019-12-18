---- IN ----
+ %table-name . column-name : integer ( 10 ) ? = 42 > another-column
---- OUT ----
$> add_table-name_column-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table-name . column-name : integer ( 10 ) ? = 42 > another-column
    UP:
        `add_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD COLUMN `column-name` INTEGER(10) DEFAULT 42 AFTER `another-column`;
        ⟩
    DOWN:
        `drop_table-name_column-name` is-dml=False ⟨
            ALTER TABLE `table-name` DROP COLUMN `column-name`;
        ⟩
.
