---- IN ----
+ %table . foo : string = 'foo\'\\bar'
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : string = 'foo\'\\bar'
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->string()->notNull()->defaultValue('foo\'\\bar')
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
