---- IN ----
+ U %table-name . column-name
---- OUT ----
$> add_idx_table_name_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + U %table-name . column-name
    UP:
        `add_idx_table_name_column_name` is-dml=False ⟨
            $this->createIndex(
                'idx-table-name-column-name',
                '{{%table-name}}',
                ['column-name'],
                true
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
