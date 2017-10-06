---- IN ----
* %table-name . column : int ( 10 ) > foo => : uint
---- OUT ----
$> alter_table_name_column
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table-name . column : int ( 10 ) > foo => : uint
    UP:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer()->notNull()->unsigned()
            );
        ⟩
    DOWN:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer(10)->notNull()->after('foo')
            );
        ⟩
.
