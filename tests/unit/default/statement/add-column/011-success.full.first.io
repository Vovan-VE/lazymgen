---- IN ----
+ %table-name . column-name : int ( 10 ) ? = 42 ^
---- OUT ----
$> add_table_name_column_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + %table-name . column-name : int ( 10 ) ? = 42 ^
    UP:
        `add_table_name_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table-name}}',
                'column-name',
                $this->integer(10)->defaultValue(42)->first()
            );
        ⟩
    DOWN:
        `drop_table_name_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table-name}}', 'column-name');
        ⟩
.
