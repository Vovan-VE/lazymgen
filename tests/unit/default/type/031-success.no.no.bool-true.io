---- IN ----
+ %table . foo : bool = TRue
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : bool = TRue
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->boolean()->notNull()->defaultValue(true)
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
