---- IN ----
+ PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_key_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_key_name` is-dml=False ⟨
            $this->addPrimaryKey(
                'key:name/',
                '{{%table@name+is|strange}}',
                ['#~column$name*']
            );
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            $this->dropPrimaryKey(
                'key:name/',
                '{{%table@name+is|strange}}'
            );
        ⟩
.
