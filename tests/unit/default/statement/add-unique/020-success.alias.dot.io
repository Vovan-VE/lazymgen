---- IN ----
+ U @key-name %table-name . column-name
---- OUT ----
$> add_key_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + U @key-name %table-name . column-name
    UP:
        `add_key_name` is-dml=False ⟨
            $this->createIndex(
                'key-name',
                '{{%table-name}}',
                ['column-name'],
                true
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
