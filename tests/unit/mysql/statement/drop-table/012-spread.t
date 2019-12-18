----IN----
  -  %table-name  (  id  :  primary  ,  name  :  string  (  )  ,  mail  :  string  (  255  )  )
----OUT----
$> drop_table-name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     -  %table-name  (  id  :  primary  ,  name  :  string  (  )  ,  mail  :  string  (  255  )  )
    UP:
        `drop_table-name` is-dml=False ⟨
            DROP TABLE `table-name`;
        ⟩
    DOWN:
        `create_table-name` is-dml=False ⟨
            CREATE TABLE `table-name` (
                `id` PRIMARY NOT NULL,
                `name` STRING NOT NULL,
                `mail` STRING(255) NOT NULL
            ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB;
        ⟩
.
