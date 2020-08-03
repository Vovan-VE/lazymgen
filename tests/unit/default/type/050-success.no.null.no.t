---- IN ----
+ %table . foo : int ?
---- OUT ----
$> add_table_foo
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : int ?
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->integer()
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
