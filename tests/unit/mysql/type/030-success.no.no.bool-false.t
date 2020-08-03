---- IN ----
+ %table . foo : bool = faLSe
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : bool = faLSe
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` BOOL NOT NULL DEFAULT FALSE;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
