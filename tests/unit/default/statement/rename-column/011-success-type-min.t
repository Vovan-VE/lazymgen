---- IN ----
* %table-name . old-column-name : int => new-column-name : int
---- OUT ----
$> rename_table_name_old_column_name_new_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table-name . old-column-name : int => new-column-name : int
    UP:
        `rename_table_name_old_column_name_new_column_name` is-dml=False ⟨
            $this->renameColumn('{{%table-name}}', 'old-column-name', 'new-column-name');
        ⟩
    DOWN:
        `rename_table_name_new_column_name_old_column_name` is-dml=False ⟨
            $this->renameColumn('{{%table-name}}', 'new-column-name', 'old-column-name');
        ⟩
.
