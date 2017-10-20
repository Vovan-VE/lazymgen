---- IN ----
+ FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> add_fk-table_name_is_strange-_column_name_-_-
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `add_fk-table_name_is_strange-_column_name_-_-` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD CONSTRAINT `fk-table@name+is|strange-#~column$name*-<>?%-!()[]`
                FOREIGN KEY (`#~column$name*`)
                REFERENCES `<>?%` (`!()[]`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
    DOWN:
        `drop_fk-table_name_is_strange-_column_name_-_-` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP FOREIGN KEY `fk-table@name+is|strange-#~column$name*-<>?%-!()[]`;
        ⟩
.
