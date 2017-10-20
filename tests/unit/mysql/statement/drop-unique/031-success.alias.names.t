---- IN ----
- U @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_key_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - U @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP UNIQUE `key:name/`;
        ⟩
    DOWN:
        `add_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD UNIQUE `key:name/` (`#~column$name*`);
        ⟩
.
