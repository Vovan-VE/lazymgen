---- IN ----
+ %table . foo : int-ai-pk
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table . foo : int-ai-pk
    UP:
        `add_table_foo` is-dml=False ⟨
            ALTER TABLE `table`
                ADD COLUMN `foo` INT AUTO_INCREMENT PRIMARY KEY;
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            ALTER TABLE `table` DROP COLUMN `foo`;
        ⟩
.
