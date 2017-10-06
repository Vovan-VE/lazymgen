---- IN ----
+ FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
---- OUT ----
$> add_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + FK %child ( foo , bar , lol ) => %parent ( lorem , ipsum , dolor )
    UP:
        `add_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor` is-dml=False ⟨
            $this->addForeignKey(
                'fk-child-foo-bar-lol-parent-lorem-ipsum-dolor',
                '{{%child}}', ['foo', 'bar', 'lol'],
                '{{%parent}}', ['lorem', 'ipsum', 'dolor'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
    DOWN:
        `drop_fk_child_foo_bar_lol_parent_lorem_ipsum_dolor` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-child-foo-bar-lol-parent-lorem-ipsum-dolor',
                '{{%child}}'
            );
        ⟩
.
