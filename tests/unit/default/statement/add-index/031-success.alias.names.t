---- IN ----
+ I @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_key_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + I @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_key_name` is-dml=False ⟨
            $this->createIndex(
                'key:name/',
                '{{%table@name+is|strange}}',
                ['#~column$name*'],
                false
            );
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            $this->dropIndex(
                'key:name/',
                '{{%table@name+is|strange}}'
            );
        ⟩
.
