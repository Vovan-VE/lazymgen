---- IN ----
- I %table-name . column-name
---- OUT ----
$> drop_idx_table_name_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - I %table-name . column-name
    UP:
        `drop_idx_table_name_column_name` is-dml=False ⟨
            $this->dropIndex(
                'idx-table-name-column-name',
                '{{%table-name}}'
            );
        ⟩
    DOWN:
        `add_idx_table_name_column_name` is-dml=False ⟨
            $this->createIndex(
                'idx-table-name-column-name',
                '{{%table-name}}',
                ['column-name'],
                false
            );
        ⟩
.
