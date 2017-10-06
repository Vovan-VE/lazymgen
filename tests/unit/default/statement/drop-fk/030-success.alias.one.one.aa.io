---- IN ----
- FK @key-name %child ( parent_id ) => %parent ( id )
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     - FK @key-name %child ( parent_id ) => %parent ( id )
    UP:
        `drop_key_name` is-dml=False ⟨
            $this->dropForeignKey(
                'key-name',
                '{{%child}}'
            );
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            $this->addForeignKey(
                'key-name',
                '{{%child}}', ['parent_id'],
                '{{%parent}}', ['id'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
.
