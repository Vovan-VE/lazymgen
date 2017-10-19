---- IN ----
- FK %child-table-long ( foo-long , bar-long , lol-long ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
---- OUT ----
$> drop_fk-child-table-long-foo-long-bar-long-lol-long-parent-long
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - FK %child-table-long ( foo-long , bar-long , lol-long ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
    UP:
        `drop_fk-child-table-long-foo-long-bar-long-lol-long-parent-long` is-dml=False ⟨
            ALTER TABLE `child-table-long`
                DROP FOREIGN KEY `fk-child-table-long-foo-long-bar-long-lol-long-parent-long`;
        ⟩
    DOWN:
        `add_fk-child-table-long-foo-long-bar-long-lol-long-parent-long` is-dml=False ⟨
            ALTER TABLE `child-table-long`
                ADD CONSTRAINT `fk-child-table-long-foo-long-bar-long-lol-long-parent-long`
                FOREIGN KEY (`foo-long`, `bar-long`, `lol-long`)
                REFERENCES `parent-long` (`lorem-long`, `ipsum-long`, `dolor-long`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
.
