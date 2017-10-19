---- IN ----
* %table-name . column : integer ( 10 ) = 42 ^ => : integer ^
---- OUT ----
$> alter_table-name_column
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer ( 10 ) = 42 ^ => : integer ^
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL FIRST;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER(10) NOT NULL DEFAULT 42 FIRST;
        ⟩
.
