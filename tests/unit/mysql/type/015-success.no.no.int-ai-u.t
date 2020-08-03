---- IN ----
+ %table . foo : int-ai-u
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int-ai-u
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
