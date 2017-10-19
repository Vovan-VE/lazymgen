---- IN ----
+ I %table-name ( column-foo , column-bar )
---- OUT ----
$> add_idx-table-name-column-foo-column-bar
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + I %table-name ( column-foo , column-bar )
    UP:
        `add_idx-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD INDEX `idx-table-name-column-foo-column-bar` (`column-foo`, `column-bar`);
        ⟩
    DOWN:
        `drop_idx-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP INDEX `idx-table-name-column-foo-column-bar`;
        ⟩
.
