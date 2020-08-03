---- IN ----
* %table-name . foo : integer(10)? = 42 ^ => bar : decimal(20,2) = 42.00 > lol
---- OUT ----
$> alter_table-name_foo_bar
    > Generated with lazymgen - Lazy Migration Generator
    > Format: MySQL
    >
    > Source:
    >     * %table-name . foo : integer(10)? = 42 ^ => bar : decimal(20,2) = 42.00 > lol
    UP:
        `alter_table-name_foo_bar` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `foo` `bar` DECIMAL(20, 2) NOT NULL DEFAULT 42.00 AFTER `lol`;
        ⟩
    DOWN:
        `alter_table-name_bar_foo` is-dml=False ⟨
            ALTER TABLE `table-name`
                CHANGE COLUMN `bar` `foo` INTEGER(10) DEFAULT 42 FIRST;
        ⟩
.
