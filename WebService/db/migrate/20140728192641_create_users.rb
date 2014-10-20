class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :name
      t.boolean :active, default: true, null: false
      t.string :password_encrypted
      t.string :salt

      t.timestamps
    end

    add_index :users, ['username', 'email'], name: 'index_unique_username_email', unique: true
  end
end
