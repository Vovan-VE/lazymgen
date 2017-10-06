---- IN ----
* %table\@name\+is\|strange => %\#\~table\$name\*
---- OUT ----
$> rename_table_name_is_strange_table_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     * %table\@name\+is\|strange => %\#\~table\$name\*
    UP:
        `rename_table_name_is_strange_table_name` is-dml=False ⟨
            $this->renameTable('{{%table@name+is|strange}}', '{{%#~table$name*}}');
        ⟩
    DOWN:
        `rename_table_name_table_name_is_strange` is-dml=False ⟨
            $this->renameTable('{{%#~table$name*}}', '{{%table@name+is|strange}}');
        ⟩
.
