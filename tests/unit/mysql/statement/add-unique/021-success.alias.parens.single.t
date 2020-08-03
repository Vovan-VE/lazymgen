---- IN ----
+ U @key-name %table-name ( column-name )
---- OUT ----
$> add_key-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + U @key-name %table-name ( column-name )
    UP:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD UNIQUE `key-name` (`column-name`);
        ⟩
    DOWN:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP UNIQUE `key-name`;
        ⟩
.
