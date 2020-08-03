---- IN ----
+ %table . foo : double = 42.37e-6
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : double = 42.37e-6
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->double()->notNull()->defaultValue(42.37e-6)
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
