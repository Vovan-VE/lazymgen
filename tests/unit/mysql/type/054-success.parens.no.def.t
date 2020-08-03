---- IN ----
+ %table . foo : int ( 10 ) = 42
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int ( 10 ) = 42
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` INT(10) NOT NULL DEFAULT 42;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
