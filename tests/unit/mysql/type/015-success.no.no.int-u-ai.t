---- IN ----
+ %table . foo : int-u-ai
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int-u-ai
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` INT UNSIGNED NOT NULL AUTO_INCREMENT;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
