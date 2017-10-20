----IN----
+%table-name(id:biginteger-u-pk,name:varchar(),mail:varchar(255))
----OUT----
$> create_table-name
    > Generated with Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     +%table-name(id:biginteger-u-pk,name:varchar(),mail:varchar(255))
    UP:
        `create_table-name` is-dml=False ⟨
            CREATE TABLE `table-name` (
                `id` BIGINTEGER UNSIGNED PRIMARY KEY,
                `name` VARCHAR NOT NULL,
                `mail` VARCHAR(255) NOT NULL
            ) CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=InnoDB;
        ⟩
    DOWN:
        `drop_table-name` is-dml=False ⟨
            DROP TABLE `table-name`;
        ⟩
.
