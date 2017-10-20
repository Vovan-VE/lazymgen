---- IN ----
+ FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> add_key_name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK @key\:name\/ %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `add_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD CONSTRAINT `key:name/`
                FOREIGN KEY (`#~column$name*`)
                REFERENCES `<>?%` (`!()[]`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
    DOWN:
        `drop_key_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP FOREIGN KEY `key:name/`;
        ⟩
.
