---- IN ----
+ %table\@name--\+is\|--strange . \#\~new--column\$name\* : int
---- OUT ----
$> add_table_name_is_strange_new_column_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table\@name--\+is\|--strange . \#\~new--column\$name\* : int
    UP:
        `add_table_name_is_strange_new_column_name` is-dml=False ⟨
            $this->addColumn(
                '{{%table@name--+is|--strange}}',
                '#~new--column$name*',
                $this->integer()->notNull()
            );
        ⟩
    DOWN:
        `drop_table_name_is_strange_new_column_name` is-dml=False ⟨
            $this->dropColumn('{{%table@name--+is|--strange}}', '#~new--column$name*');
        ⟩
.
