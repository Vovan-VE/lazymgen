---- IN ----
- FK %child-table-long ( foo-long , bar-long , lol-long ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
---- OUT ----
$> drop_fk_child_table_long_foo_long_bar_long_lol_long_parent_long
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     - FK %child-table-long ( foo-long , bar-long , lol-long ) => %parent-long ( lorem-long , ipsum-long , dolor-long )
    UP:
        `drop_fk_child_table_long_foo_long_bar_long_lol_long_parent_long` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-child-table-long-foo-long-bar-long-lol-long-parent-long',
                '{{%child-table-long}}'
            );
        ⟩
    DOWN:
        `add_fk_child_table_long_foo_long_bar_long_lol_long_parent_long` is-dml=False ⟨
            $this->addForeignKey(
                'fk-child-table-long-foo-long-bar-long-lol-long-parent-long',
                '{{%child-table-long}}', ['foo-long', 'bar-long', 'lol-long'],
                '{{%parent-long}}', ['lorem-long', 'ipsum-long', 'dolor-long'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
.
