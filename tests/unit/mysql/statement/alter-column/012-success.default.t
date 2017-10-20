---- IN ----
* %table-name . column : integer = 42 => : integer-u
---- OUT ----
$> alter_table-name_column
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer = 42 => : integer-u
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER UNSIGNED NOT NULL;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL DEFAULT 42;
        ⟩
.
