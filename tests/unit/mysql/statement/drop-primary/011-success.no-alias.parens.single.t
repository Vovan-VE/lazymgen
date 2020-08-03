---- IN ----
- PK %table-name ( column-name )
---- OUT ----
$> drop_pk-table-name-column-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - PK %table-name ( column-name )
    UP:
        `drop_pk-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
    DOWN:
        `add_pk-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-name`);
        ⟩
.
