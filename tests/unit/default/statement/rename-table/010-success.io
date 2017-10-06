---- IN ----
* %old-table-name => %new-table-name
---- OUT ----
$> rename_old_table_name_new_table_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %old-table-name => %new-table-name
    UP:
        `rename_old_table_name_new_table_name` is-dml=False ⟨
            $this->renameTable('{{%old-table-name}}', '{{%new-table-name}}');
        ⟩
    DOWN:
        `rename_new_table_name_old_table_name` is-dml=False ⟨
            $this->renameTable('{{%new-table-name}}', '{{%old-table-name}}');
        ⟩
.
