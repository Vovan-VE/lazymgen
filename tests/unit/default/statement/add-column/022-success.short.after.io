---- IN ----
+ %table-name . column-name : int > another-column
---- OUT ----
$> add_table_name_column_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table-name . column-name : int > another-column
    UP:
        `add_table_name_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table-name}}',
                'column-name',
                $this->integer()->notNull()->after('another-column')
            );
        ⟩
    DOWN:
        `drop_table_name_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table-name}}', 'column-name');
        ⟩
.
