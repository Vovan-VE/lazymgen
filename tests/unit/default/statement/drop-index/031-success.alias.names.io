---- IN ----
- I @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator/0.0.1
    > Format: Yii2
    >
    > Source:
    >     - I @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_key_name` is-dml=False ⟨
            $this->dropIndex(
                'key:name/',
                '{{%table@name+is|strange}}'
            );
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            $this->createIndex(
                'key:name/',
                '{{%table@name+is|strange}}',
                ['#~column$name*'],
                false
            );
        ⟩
.
