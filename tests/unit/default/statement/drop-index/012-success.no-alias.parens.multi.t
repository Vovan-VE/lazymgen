---- IN ----
- I %table-name ( column-foo , column-bar )
---- OUT ----
$> drop_idx_table_name_column_foo_column_bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - I %table-name ( column-foo , column-bar )
    UP:
        `drop_idx_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->dropIndex(
                'idx-table-name-column-foo-column-bar',
                '{{%table-name}}'
            );
        ⟩
    DOWN:
        `add_idx_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->createIndex(
                'idx-table-name-column-foo-column-bar',
                '{{%table-name}}',
                ['column-foo', 'column-bar'],
                false
            );
        ⟩
.
