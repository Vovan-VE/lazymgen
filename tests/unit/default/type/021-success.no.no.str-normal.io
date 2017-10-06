---- IN ----
+ %table . foo : string = 'foo'
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : string = 'foo'
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->string()->notNull()->defaultValue('foo')
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
