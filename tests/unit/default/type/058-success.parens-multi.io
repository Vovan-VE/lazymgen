---- IN ----
+ %table . foo : decimal ( 20 , 10 )
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : decimal ( 20 , 10 )
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->decimal(20, 10)->notNull()
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
