---- IN ----
* %table-name . column : integer ( 10 ) > foo => : integer ^
---- OUT ----
$> alter_table-name_column
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer ( 10 ) > foo => : integer ^
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL FIRST;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER(10) NOT NULL AFTER `foo`;
        ⟩
.
