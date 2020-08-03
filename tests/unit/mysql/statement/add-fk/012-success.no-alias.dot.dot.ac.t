---- IN ----
+ FK %child . parent_id => %parent . id *>
---- OUT ----
$> add_fk-child-parent_id-parent-id
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK %child . parent_id => %parent . id *>
    UP:
        `add_fk-child-parent_id-parent-id` is-dml=False ⟨
            ALTER TABLE `child`
                ADD CONSTRAINT `fk-child-parent_id-parent-id`
                FOREIGN KEY (`parent_id`)
                REFERENCES `parent` (`id`)
                ON DELETE RESTRICT
                ON UPDATE CASCADE;
        ⟩
    DOWN:
        `drop_fk-child-parent_id-parent-id` is-dml=False ⟨
            ALTER TABLE `child`
                DROP FOREIGN KEY `fk-child-parent_id-parent-id`;
        ⟩
.
