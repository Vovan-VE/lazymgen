---- IN ----
- FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `drop_key_name` is-dml=False ⟨
            $this->dropForeignKey(
                'key:name/',
                '{{%table@name+is|strange}}'
            );
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            $this->addForeignKey(
                'key:name/',
                '{{%table@name+is|strange}}', ['#~column$name*'],
                '{{%<>?%}}', ['!()[]'],
                'RESTRICT',
                'RESTRICT'
            );
        ⟩
.
