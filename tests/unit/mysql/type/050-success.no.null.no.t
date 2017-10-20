---- IN ----
+ %table . foo : int ?
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int ?
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` INT;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
