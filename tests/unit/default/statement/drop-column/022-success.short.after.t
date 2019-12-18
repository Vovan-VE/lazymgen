---- IN ----
- %table-name . column-name : int > another-column
---- OUT ----
$> drop_table_name_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - %table-name . column-name : int > another-column
    UP:
        `drop_table_name_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table-name}}', 'column-name');
        ⟩
    DOWN:
        `add_table_name_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table-name}}',
                'column-name',
                $this->integer()->notNull()->after('another-column')
            );
        ⟩
.
