---- IN ----
- I %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_idx_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - I %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_idx_table_name_is_strange_column_name` is-dml=False ⟨
            $this->dropIndex(
                'idx-table@name+is|strange-#~column$name*',
                '{{%table@name+is|strange}}'
            );
        ⟩
    DOWN:
        `add_idx_table_name_is_strange_column_name` is-dml=False ⟨
            $this->createIndex(
                'idx-table@name+is|strange-#~column$name*',
                '{{%table@name+is|strange}}',
                ['#~column$name*'],
                false
            );
        ⟩
.
