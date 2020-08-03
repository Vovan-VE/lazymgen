---- IN ----
+ U %table-name ( column-foo , column-bar )
---- OUT ----
$> add_idx-table-name-column-foo-column-bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + U %table-name ( column-foo , column-bar )
    UP:
        `add_idx-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD UNIQUE `idx-table-name-column-foo-column-bar` (`column-foo`, `column-bar`);
        ⟩
    DOWN:
        `drop_idx-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP UNIQUE `idx-table-name-column-foo-column-bar`;
        ⟩
.
