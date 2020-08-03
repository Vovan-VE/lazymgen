---- IN ----
+ %table . foo : double = 42.37
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : double = 42.37
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` DOUBLE NOT NULL DEFAULT 42.37;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
