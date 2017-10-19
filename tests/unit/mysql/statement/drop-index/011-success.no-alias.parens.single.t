---- IN ----
- I %table-name ( column-name )
---- OUT ----
$> drop_idx-table-name-column-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - I %table-name ( column-name )
    UP:
        `drop_idx-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP INDEX `idx-table-name-column-name`;
        ⟩
    DOWN:
        `add_idx-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD INDEX `idx-table-name-column-name` (`column-name`);
        ⟩
.
