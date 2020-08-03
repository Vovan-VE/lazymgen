---- IN ----
- %table\@name\+is\|strange ( \#\~column\$name\* : int )
---- OUT ----
$> drop_table_name_is_strange
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     - %table\@name\+is\|strange ( \#\~column\$name\* : int )
    UP:
        `drop_table_name_is_strange` is-dml=False ⟨
            DROP TABLE `table@name+is|strange`;
        ⟩
    DOWN:
        `create_table_name_is_strange` is-dml=False ⟨
            CREATE TABLE `table@name+is|strange` (
                `#~column$name*` INT NOT NULL
            ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB;
        ⟩
.
