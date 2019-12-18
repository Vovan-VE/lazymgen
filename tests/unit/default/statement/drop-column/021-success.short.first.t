---- IN ----
- %table-name . column-name : int ^
---- OUT ----
$> drop_table_name_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - %table-name . column-name : int ^
    UP:
        `drop_table_name_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table-name}}', 'column-name');
        ⟩
    DOWN:
        `add_table_name_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table-name}}',
                'column-name',
                $this->integer()->notNull()->first()
            );
        ⟩
.
