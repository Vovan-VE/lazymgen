----IN----
+ %table-name (id:primary, name:string(), mail:string(255) )
----OUT----
$> create_table_name
    > Generated with lazymgen - Lazy Migration Generator
    > Format: Yii2
    >
    > Source:
    >     + %table-name (id:primary, name:string(), mail:string(255) )
    UP:
        `create_table_name` is-dml=False ⟨
            $tableOptions = null;
            if ($this->db->driverName === 'mysql') {
                // https://stackoverflow.com/q/766809
                $tableOptions = 'CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB';
            }

            $this->createTable('{{%table-name}}', [
                'id' => $this->primaryKey(),
                'name' => $this->string()->notNull(),
                'mail' => $this->string(255)->notNull(),
            ], $tableOptions);
        ⟩
    DOWN:
        `drop_table_name` is-dml=False ⟨
            $this->dropTable('{{%table-name}}');
        ⟩
.
