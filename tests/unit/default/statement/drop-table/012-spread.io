----IN----
  -  %table-name  (  id  :  primary  ,  name  :  string  (  )  ,  mail  :  string  (  255  )  )
----OUT----
$> drop_table_name
    > Generated with Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     -  %table-name  (  id  :  primary  ,  name  :  string  (  )  ,  mail  :  string  (  255  )  )
    UP:
        `drop_table_name` is-dml=False ⟨
            $this->dropTable('{{%table-name}}');
        ⟩
    DOWN:
        `create_table_name` is-dml=False ⟨
            $tableOptions = null;
            if ($this->db->driverName === 'mysql') {
                // https://stackoverflow.com/q/766809
                $tableOptions = 'CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=InnoDB';
            }

            $this->createTable('{{%table-name}}', [
                'id' => $this->primaryKey(),
                'name' => $this->string()->notNull(),
                'mail' => $this->string(255)->notNull(),
            ], $tableOptions);
        ⟩
.
