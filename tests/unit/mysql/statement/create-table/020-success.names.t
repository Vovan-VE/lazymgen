---- IN ----
+ %table\@name\+is\|strange ( \#\~column\$name\* : varchar )
---- OUT ----
$> create_table_name_is_strange
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     + %table\@name\+is\|strange ( \#\~column\$name\* : varchar )
    UP:
        `create_table_name_is_strange` is-dml=False ⟨
            CREATE TABLE `table@name+is|strange` (
                `#~column$name*` VARCHAR NOT NULL
            ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB;
        ⟩
    DOWN:
        `drop_table_name_is_strange` is-dml=False ⟨
            DROP TABLE `table@name+is|strange`;
        ⟩
.
