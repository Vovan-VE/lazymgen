---- IN ----
* %table\@name\+is\|strange . \#\~column\$name\* => \!\(\)\[\]
---- OUT ----
$> rename_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table\@name\+is\|strange . \#\~column\$name\* => \!\(\)\[\]
    UP:
        `rename_table_name_is_strange_column_name` is-dml=False ⟨
            $this->renameColumn('{{%table@name+is|strange}}', '#~column$name*', '!()[]');
        ⟩
    DOWN:
        `rename_table_name_is_strange_column_name` is-dml=False ⟨
            $this->renameColumn('{{%table@name+is|strange}}', '!()[]', '#~column$name*');
        ⟩
.
