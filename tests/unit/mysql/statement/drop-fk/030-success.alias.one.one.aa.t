---- IN ----
- FK @key-name %child ( parent_id ) => %parent ( id )
---- OUT ----
$> drop_key-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - FK @key-name %child ( parent_id ) => %parent ( id )
    UP:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `child`
                DROP FOREIGN KEY `key-name`;
        ⟩
    DOWN:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `child`
                ADD CONSTRAINT `key-name`
                FOREIGN KEY (`parent_id`)
                REFERENCES `parent` (`id`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
.
