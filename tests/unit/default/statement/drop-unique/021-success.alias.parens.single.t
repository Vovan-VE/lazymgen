---- IN ----
- U @key-name %table-name ( column-name )
---- OUT ----
$> drop_key_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - U @key-name %table-name ( column-name )
    UP:
        `drop_key_name` is-dml=False ⟨
            $this->dropIndex(
                'key-name',
                '{{%table-name}}'
            );
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            $this->createIndex(
                'key-name',
                '{{%table-name}}',
                ['column-name'],
                true
            );
        ⟩
.
