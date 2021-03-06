---- IN ----
- %table-name . column-name : int ( 10 ) ? = 42 ^
---- OUT ----
$> drop_table_name_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - %table-name . column-name : int ( 10 ) ? = 42 ^
    UP:
        `drop_table_name_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table-name}}', 'column-name');
        ⟩
    DOWN:
        `add_table_name_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table-name}}',
                'column-name',
                $this->integer(10)->defaultValue(42)->first()
            );
        ⟩
.
