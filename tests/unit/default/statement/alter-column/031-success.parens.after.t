---- IN ----
* %table-name . column : int ( 10 ) > foo => : uint > bar
---- OUT ----
$> alter_table_name_column
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table-name . column : int ( 10 ) > foo => : uint > bar
    UP:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer()->notNull()->unsigned()->after('bar')
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
