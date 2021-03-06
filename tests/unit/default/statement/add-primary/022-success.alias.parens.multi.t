---- IN ----
+ PK @key-name %table-name ( column-foo , column-bar )
---- OUT ----
$> add_key_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + PK @key-name %table-name ( column-foo , column-bar )
    UP:
        `add_key_name` is-dml=False ⟨
            $this->addPrimaryKey(
                'key-name',
                '{{%table-name}}',
                ['column-foo', 'column-bar']
            );
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            $this->dropPrimaryKey(
                'key-name',
                '{{%table-name}}'
            );
        ⟩
.
