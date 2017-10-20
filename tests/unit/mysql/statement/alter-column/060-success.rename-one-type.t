---- IN ----
* %table-name . foo : integer => bar
---- OUT ----
$> rename_table-name_foo_bar
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . foo : integer => bar
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
