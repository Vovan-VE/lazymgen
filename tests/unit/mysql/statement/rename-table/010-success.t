---- IN ----
* %old-table-name => %new-table-name
---- OUT ----
$> rename_old-table-name_new-table-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %old-table-name => %new-table-name
    UP:
        `rename_old-table-name_new-table-name` is-dml=False ⟨
            ALTER TABLE `old-table-name`
                RENAME TO `new-table-name`;
        ⟩
    DOWN:
        `rename_new-table-name_old-table-name` is-dml=False ⟨
            ALTER TABLE `new-table-name`
                RENAME TO `old-table-name`;
        ⟩
.
