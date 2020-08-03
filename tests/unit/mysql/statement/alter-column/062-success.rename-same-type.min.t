---- IN ----
* %table-name . foo : integer ( 10 ) ? = 42 > a => bar : integer(10)?=42>a
---- OUT ----
$> rename_table-name_foo_bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . foo : integer ( 10 ) ? = 42 > a => bar : integer(10)?=42>a
    UP:
        `rename_table-name_foo_bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `foo` `bar` INTEGER(10) DEFAULT 42 AFTER `a`;
        ⟩
    DOWN:
        `rename_table-name_bar_foo` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `bar` `foo` INTEGER(10) DEFAULT 42 AFTER `a`;
        ⟩
.
