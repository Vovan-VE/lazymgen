---- IN ----
- PK %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_pk_table_name_is_strange_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - PK %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_pk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->dropPrimaryKey(
                'pk-table@name+is|strange-#~column$name*',
                '{{%table@name+is|strange}}'
            );
        ⟩
    DOWN:
        `add_pk_table_name_is_strange_column_name` is-dml=False ⟨
            $this->addPrimaryKey(
                'pk-table@name+is|strange-#~column$name*',
                '{{%table@name+is|strange}}',
                ['#~column$name*']
            );
        ⟩
.
