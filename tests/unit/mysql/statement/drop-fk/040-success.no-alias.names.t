---- IN ----
- FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
---- OUT ----
$> drop_fk-table_name_is_strange-_column_name_-_-
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - FK %table\@name\+is\|strange . \#\~column\$name\* => %\<\>\?\% . \!\(\)\[\]
    UP:
        `drop_fk-table_name_is_strange-_column_name_-_-` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP FOREIGN KEY `fk-table@name+is|strange-#~column$name*-<>?%-!()[]`;
        ⟩
    DOWN:
        `add_fk-table_name_is_strange-_column_name_-_-` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD CONSTRAINT `fk-table@name+is|strange-#~column$name*-<>?%-!()[]`
                FOREIGN KEY (`#~column$name*`)
                REFERENCES `<>?%` (`!()[]`)
                ON DELETE RESTRICT
                ON UPDATE RESTRICT;
        ⟩
.
