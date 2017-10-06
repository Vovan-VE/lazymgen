---- IN ----
- FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
---- OUT ----
$> drop_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     - FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
    UP:
        `drop_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-child-foo-bar-lol-parent-lorem-ipsum-dolor',
                '{{%child}}'
            );
        ⟩
    DOWN:
        `add_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor` is-dml=False ⟨
            $this->addForeignKey(
                'fk-child-foo-bar-lol-parent-lorem-ipsum-dolor',
                '{{%child}}', ['foo', 'bar', 'lol'],
                '{{%parent}}', ['lorem', 'ipsum', 'dolor'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
.
