---- IN ----
- %table\@name\+is\|strange . \#\~column\$name\* : int
---- OUT ----
$> drop_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     - %table\@name\+is\|strange . \#\~column\$name\* : int
    UP:
        `drop_table_name_is_strange_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table@name+is|strange}}', '#~column$name*');
        ⟩
    DOWN:
        `add_table_name_is_strange_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table@name+is|strange}}',
                '#~column$name*',
                $this->integer()->notNull()
            );
        ⟩
.
