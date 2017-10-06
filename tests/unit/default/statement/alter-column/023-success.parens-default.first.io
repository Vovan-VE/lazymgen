---- IN ----
* %table-name . column : int ( 10 ) = 42 ^ => : uint ^
---- OUT ----
$> alter_table_name_column
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     * %table-name . column : int ( 10 ) = 42 ^ => : uint ^
    UP:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer()->notNull()->unsigned()->first()
            );
        ⟩
    DOWN:
        `alter_table_name_column` is-dml=False ⟨
            $this->alterColumn(
                '{{%table-name}}',
                'column',
                $this->integer(10)->notNull()->defaultValue(42)->first()
            );
        ⟩
.
