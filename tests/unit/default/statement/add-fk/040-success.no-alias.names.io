---- IN ----
+ FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> add_fk_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `add_fk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->addForeignKey(
                'fk-table@name+is|strange-#~column$name*-<>?%-!()[]',
                '{{%table@name+is|strange}}', ['#~column$name*'],
                '{{%<>?%}}', ['!()[]'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
    DOWN:
        `drop_fk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-table@name+is|strange-#~column$name*-<>?%-!()[]',
                '{{%table@name+is|strange}}'
            );
        ⟩
.
