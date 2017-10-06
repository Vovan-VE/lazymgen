---- IN ----
+ I %table-name . column-name
---- OUT ----
$> add_idx_table_name_column_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + I %table-name . column-name
    UP:
        `add_idx_table_name_column_name` is-dml=False ⟨
            $this->createIndex(
                'idx-table-name-column-name',
                '{{%table-name}}',
                ['column-name'],
                false
            );
        ⟩
    DOWN:
        `drop_idx_table_name_column_name` is-dml=False ⟨
            $this->dropIndex(
                'idx-table-name-column-name',
                '{{%table-name}}'
            );
        ⟩
.
