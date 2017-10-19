---- IN ----
* %table-name . column : integer = 42 > foo => : integer > bar
---- OUT ----
$> alter_table-name_column
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer = 42 > foo => : integer > bar
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL AFTER `bar`;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL DEFAULT 42 AFTER `foo`;
        ⟩
.
