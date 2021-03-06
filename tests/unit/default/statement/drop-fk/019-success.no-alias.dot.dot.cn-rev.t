---- IN ----
- FK %child . parent_id => %parent . id *> ~?
---- OUT ----
$> drop_fk_child_parent_id_parent_id
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - FK %child . parent_id => %parent . id *> ~?
    UP:
        `drop_fk_child_parent_id_parent_id` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-child-parent_id-parent-id',
                '{{%child}}'
            );
        ⟩
    DOWN:
        `add_fk_child_parent_id_parent_id` is-dml=False ⟨
            $this->addForeignKey(
                'fk-child-parent_id-parent-id',
                '{{%child}}', ['parent_id'],
                '{{%parent}}', ['id'],
                'SET NULL',
                'CASCADE'
            );
        ⟩
.
