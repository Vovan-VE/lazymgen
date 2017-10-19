---- IN ----
- PK @key-name %table-name . column-name
---- OUT ----
$> drop_key-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - PK @key-name %table-name . column-name
    UP:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
    DOWN:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-name`);
        ⟩
.
