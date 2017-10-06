---- IN ----
+ %table . foo : int = -23
---- OUT ----
$> add_table_foo
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table . foo : int = -23
    UP:
        `add_table_foo` is-dml=False ⟨
            $this->addColumn(
                '{{%table}}',
                'foo',
                $this->integer()->notNull()->defaultValue(-23)
            );
        ⟩
    DOWN:
        `drop_table_foo` is-dml=False ⟨
            $this->dropColumn('{{%table}}', 'foo');
        ⟩
.
