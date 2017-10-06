---- IN ----
* %table\@name\+is\|strange . \#\~column\$name\* : int > \$\%t\; => : uint > \ \ \.
---- OUT ----
$> alter_table_name_is_strange_column_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     * %table\@name\+is\|strange . \#\~column\$name\* : int > \$\%t\; => : uint > \ \ \.
    UP:
        `alter_table_name_is_strange_column_name` is-dml=False ⟨
            $this->alterColumn(
                '{{%table@name+is|strange}}',
                '#~column$name*',
                $this->integer()->notNull()->unsigned()->after('  .')
            );
        ⟩
    DOWN:
        `alter_table_name_is_strange_column_name` is-dml=False ⟨
            $this->alterColumn(
                '{{%table@name+is|strange}}',
                '#~column$name*',
                $this->integer()->notNull()->after('$%t;')
            );
        ⟩
.
