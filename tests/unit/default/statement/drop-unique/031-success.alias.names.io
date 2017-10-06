---- IN ----
- U @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     - U @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
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
                true
            );
        ⟩
.
