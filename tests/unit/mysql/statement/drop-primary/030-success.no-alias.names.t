---- IN ----
- PK %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> drop_pk-table_name_is_strange-_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - PK %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `drop_pk-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP PRIMARY KEY;
        ⟩
    DOWN:
        `add_pk-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD PRIMARY KEY (`#~column$name*`);
        ⟩
.
