---- IN ----
+ PK %table-name ( column-foo , column-bar )
---- OUT ----
$> add_pk-table-name-column-foo-column-bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK %table-name ( column-foo , column-bar )
    UP:
        `add_pk-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-foo`, `column-bar`);
        ⟩
    DOWN:
        `drop_pk-table-name-column-foo-column-bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
.
