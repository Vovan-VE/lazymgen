---- IN ----
+ FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
---- OUT ----
$> add_fk-child-foo-bar-lol-parent-lorem-ipsum-dolor
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
    UP:
        `add_fk-child-foo-bar-lol-parent-lorem-ipsum-dolor` is-dml=False ⟨
            ALTER TABLE `child`
                ADD CONSTRAINT `fk-child-foo-bar-lol-parent-lorem-ipsum-dolor`
                FOREIGN KEY (`foo`, `bar`, `lol`)
                REFERENCES `parent` (`lorem`, `ipsum`, `dolor`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
    DOWN:
        `drop_fk-child-foo-bar-lol-parent-lorem-ipsum-dolor` is-dml=False ⟨
            ALTER TABLE `child`
                DROP FOREIGN KEY `fk-child-foo-bar-lol-parent-lorem-ipsum-dolor`;
        ⟩
.
