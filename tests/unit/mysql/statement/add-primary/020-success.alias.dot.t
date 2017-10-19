---- IN ----
+ PK @key-name %table-name . column-name
---- OUT ----
$> add_key-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK @key-name %table-name . column-name
    UP:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD PRIMARY KEY (`column-name`);
        ⟩
    DOWN:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP PRIMARY KEY;
        ⟩
.
