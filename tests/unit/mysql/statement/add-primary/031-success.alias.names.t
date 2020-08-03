---- IN ----
+ PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_key_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD PRIMARY KEY (`#~column$name*`);
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP PRIMARY KEY;
        ⟩
.
