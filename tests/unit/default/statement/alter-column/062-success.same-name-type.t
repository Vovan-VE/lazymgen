---- IN ----
* %table-name . column : int => : int
---- OUT ----
$> alter_table_name_column
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table-name . column : int => : int
    UP:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer()->notNull()
            );
        ⟩
    DOWN:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer()->notNull()
            );
        ⟩
.
