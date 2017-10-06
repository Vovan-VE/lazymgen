---- IN ----
+ I %table-name ( column-foo , column-bar )
---- OUT ----
$> add_idx_table_name_column_foo_column_bar
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + I %table-name ( column-foo , column-bar )
    UP:
        `add_idx_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->createIndex(
                'idx-table-name-column-foo-column-bar',
                '{{%table-name}}',
                ['column-foo', 'column-bar'],
                false
            );
        ⟩
    DOWN:
        `drop_idx_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->dropIndex(
                'idx-table-name-column-foo-column-bar',
                '{{%table-name}}'
            );
        ⟩
.
