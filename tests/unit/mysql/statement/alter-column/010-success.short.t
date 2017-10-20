---- IN ----
* %table-name . column : integer => : integer-u
---- OUT ----
$> alter_table-name_column
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer => : integer-u
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER UNSIGNED NOT NULL;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL;
        ⟩
.
