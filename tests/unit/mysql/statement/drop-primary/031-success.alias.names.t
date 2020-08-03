---- IN ----
- PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_key_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - PK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP PRIMARY KEY;
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD PRIMARY KEY (`#~column$name*`);
        ⟩
.
