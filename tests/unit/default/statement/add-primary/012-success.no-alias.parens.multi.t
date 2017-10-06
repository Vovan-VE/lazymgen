---- IN ----
+ PK %table-name ( column-foo , column-bar )
---- OUT ----
$> add_pk_table_name_column_foo_column_bar
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + PK %table-name ( column-foo , column-bar )
    UP:
        `add_pk_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->addPrimaryKey(
                'pk-table-name-column-foo-column-bar',
                '{{%table-name}}',
                ['column-foo', 'column-bar']
            );
        ⟩
    DOWN:
        `drop_pk_table_name_column_foo_column_bar` is-dml=False ⟨
            $this->dropPrimaryKey(
                'pk-table-name-column-foo-column-bar',
                '{{%table-name}}'
            );
        ⟩
.
