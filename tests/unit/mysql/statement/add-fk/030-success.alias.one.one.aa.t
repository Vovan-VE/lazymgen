---- IN ----
+ FK @key-name %child ( parent_id ) => %parent ( id )
---- OUT ----
$> add_key-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK @key-name %child ( parent_id ) => %parent ( id )
    UP:
        `add_key-name` is-dml=False ⟨
            ALTER TABLE `child`
                ADD CONSTRAINT `key-name`
                FOREIGN KEY (`parent_id`)
                REFERENCES `parent` (`id`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
    DOWN:
        `drop_key-name` is-dml=False ⟨
            ALTER TABLE `child`
                DROP FOREIGN KEY `key-name`;
        ⟩
.
