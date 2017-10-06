---- IN ----
+ FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> add_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `add_key_name` is-dml=False ⟨
            $this->addForeignKey(
                'key:name/',
                '{{%table@name+is|strange}}', ['#~column$name*'],
                '{{%<>?%}}', ['!()[]'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            $this->dropForeignKey(
                'key:name/',
                '{{%table@name+is|strange}}'
            );
        ⟩
.
