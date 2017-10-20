---- IN ----
+ PK %table-name . column-name
---- OUT ----
$> add_pk-table-name-column-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK %table-name . column-name
    UP:
        `add_pk-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-name`);
        ⟩
    DOWN:
        `drop_pk-table-name-column-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
.
