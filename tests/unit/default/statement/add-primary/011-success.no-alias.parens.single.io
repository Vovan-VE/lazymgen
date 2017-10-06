---- IN ----
+ PK %table-name ( column-name )
---- OUT ----
$> add_pk_table_name_column_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + PK %table-name ( column-name )
    UP:
        `add_pk_table_name_column_name` is-dml=False ⟨
            $this->addPrimaryKey(
                'pk-table-name-column-name',
                '{{%table-name}}',
                ['column-name']
            );
        ⟩
    DOWN:
        `drop_pk_table_name_column_name` is-dml=False ⟨
            $this->dropPrimaryKey(
                'pk-table-name-column-name',
                '{{%table-name}}'
            );
        ⟩
.
