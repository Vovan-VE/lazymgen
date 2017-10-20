---- IN ----
+ FK %child-table-long ( foo-long , bar , lol ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
---- OUT ----
$> add_fk-child-table-long-foo-long-bar-lol-parent-long-lorem-long
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK %child-table-long ( foo-long , bar , lol ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
    UP:
        `add_fk-child-table-long-foo-long-bar-lol-parent-long-lorem-long` is-dml=False ⟨
            ALTER TABLE `child-table-long`
                ADD CONSTRAINT `fk-child-table-long-foo-long-bar-lol-parent-long-lorem-long`
                FOREIGN KEY (`foo-long`, `bar`, `lol`)
                REFERENCES `parent-long` (`lorem-long`, `ipsum-long`, `dolor-long`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
    DOWN:
        `drop_fk-child-table-long-foo-long-bar-lol-parent-long-lorem-long` is-dml=False ⟨
            ALTER TABLE `child-table-long`
                DROP FOREIGN KEY `fk-child-table-long-foo-long-bar-lol-parent-long-lorem-long`;
        ⟩
.
