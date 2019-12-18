---- IN ----
- FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> drop_fk_table_name_is_strange_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `drop_fk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->dropForeignKey(
                'fk-table@name+is|strange-#~column$name*-<>?%-!()[]',
                '{{%table@name+is|strange}}'
            );
        ⟩
    DOWN:
        `add_fk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->addForeignKey(
                'fk-table@name+is|strange-#~column$name*-<>?%-!()[]',
                '{{%table@name+is|strange}}', ['#~column$name*'],
                '{{%<>?%}}', ['!()[]'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
.
