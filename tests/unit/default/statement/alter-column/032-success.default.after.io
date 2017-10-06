---- IN ----
* %table-name . column : int = 42 > foo => : uint > bar
---- OUT ----
$> alter_table_name_column
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     * %table-name . column : int = 42 > foo => : uint > bar
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
                $this->integer()->notNull()->defaultValue(42)->after('foo')
            );
        ⟩
.
