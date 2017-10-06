---- IN ----
- PK @key-name %table-name ( column-name )
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - PK @key-name %table-name ( column-name )
    UP:
        `drop_key_name` is-dml=False ⟨
            $this->dropPrimaryKey(
                'key-name',
                '{{%table-name}}'
            );
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            $this->addPrimaryKey(
                'key-name',
                '{{%table-name}}',
                ['column-name']
            );
        ⟩
.
