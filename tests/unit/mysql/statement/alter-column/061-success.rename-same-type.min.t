---- IN ----
* %table-name . foo : integer => bar : integer
---- OUT ----
$> rename_table-name_foo_bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . foo : integer => bar : integer
    UP:
        `rename_table-name_foo_bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `foo` `bar` INTEGER NOT NULL;
        ⟩
    DOWN:
        `rename_table-name_bar_foo` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `bar` `foo` INTEGER NOT NULL;
        ⟩
.
