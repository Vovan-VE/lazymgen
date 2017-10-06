---- IN ----
+ I @key-name %table-name ( column-foo , column-bar )
---- OUT ----
$> add_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + I @key-name %table-name ( column-foo , column-bar )
    UP:
        `add_key_name` is-dml=False ⟨
            $this->createIndex(
                'key-name',
                '{{%table-name}}',
                ['column-foo', 'column-bar'],
                false
            );
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            $this->dropIndex(
                'key-name',
                '{{%table-name}}'
            );
        ⟩
.
