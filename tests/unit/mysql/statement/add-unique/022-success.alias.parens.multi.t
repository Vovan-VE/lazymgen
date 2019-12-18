---- IN ----
+ U @key-name %table-name ( column-foo , column-bar )
---- OUT ----
$> add_key-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + U @key-name %table-name ( column-foo , column-bar )
    UP:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                ADD UNIQUE `key-name` (`column-foo`, `column-bar`);
        ⟩
    DOWN:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `table-name`
                DROP UNIQUE `key-name`;
        ⟩
.
