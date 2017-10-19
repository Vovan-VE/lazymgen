---- IN ----
* %table-name . old-column-name => new-column-name
---- OUT ----
$> rename_table-name_old-column-name_new-column-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . old-column-name => new-column-name
    UP:
        `rename_table-name_old-column-name_new-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `old-column-name` `new-column-name` /* same type definition here */;
        ⟩
    DOWN:
        `rename_table-name_new-column-name_old-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `new-column-name` `old-column-name` /* same type definition here */;
        ⟩
.
