---- IN ----
* %table-name . column : integer ( 10 ) => : integer > foo
---- OUT ----
$> alter_table-name_column
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . column : integer ( 10 ) => : integer > foo
    UP:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER NOT NULL AFTER `foo`;
        ⟩
    DOWN:
        `alter_table-name_column` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `column` `column` INTEGER(10) NOT NULL;
        ⟩
.
