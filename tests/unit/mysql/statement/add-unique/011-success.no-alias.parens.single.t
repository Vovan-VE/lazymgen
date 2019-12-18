---- IN ----
+ U %table-name ( column-name )
---- OUT ----
$> add_idx-table-name-column-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + U %table-name ( column-name )
    UP:
        `add_idx-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD UNIQUE `idx-table-name-column-name` (`column-name`);
        ⟩
    DOWN:
        `drop_idx-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP UNIQUE `idx-table-name-column-name`;
        ⟩
.
