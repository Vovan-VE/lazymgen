---- IN ----
- PK %table-name ( column-foo , column-bar )
---- OUT ----
$> drop_pk-table-name-column-foo-column-bar
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - PK %table-name ( column-foo , column-bar )
    UP:
        `drop_pk-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
    DOWN:
        `add_pk-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-foo`, `column-bar`);
        ⟩
.
