---- IN ----
+ %table . foo : int-ai
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int-ai
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` INT NOT NULL AUTO_INCREMENT;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
