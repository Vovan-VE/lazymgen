---- IN ----
+ PK %table\@name\+is\|strange . \#\~column\$name\*
---- OUT ----
$> add_pk-table_name_is_strange-_column_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + PK %table\@name\+is\|strange . \#\~column\$name\*
    UP:
        `add_pk-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                ADD PRIMARY KEY (`#~column$name*`);
        ⟩
    DOWN:
        `drop_pk-table_name_is_strange-_column_name` is-dml=False ⟨
            ALTER TABLE `table@name+is|strange`
                DROP PRIMARY KEY;
        ⟩
.
