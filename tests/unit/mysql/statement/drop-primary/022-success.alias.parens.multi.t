---- IN ----
+ PK @key-name %table-name ( column-foo , column-bar )
---- OUT ----
$> add_key-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK @key-name %table-name ( column-foo , column-bar )
    UP:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-foo`, `column-bar`);
        ⟩
    DOWN:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
.
