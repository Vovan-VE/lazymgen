---- IN ----
+ %table\@name\+is\|strange ( \#\~column\$name\* : int )
---- OUT ----
$> create_table_name_is_strange
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table\@name\+is\|strange ( \#\~column\$name\* : int )
    UP:
        `create_table_name_is_strange` is-dml=False ⟨
            $tableOptions = null;
            if ($this->db->driverName === 'mysql') {
                // https://stackoverflow.com/q/766809
                $tableOptions = 'CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=InnoDB';
            }

            $this->createTable('{{%table@name+is|strange}}', [
                '#~column$name*' => $this->integer()->notNull(),
            ], $tableOptions);
        ⟩
    DOWN:
        `drop_table_name_is_strange` is-dml=False ⟨
            $this->dropTable('{{%table@name+is|strange}}');
        ⟩
.
