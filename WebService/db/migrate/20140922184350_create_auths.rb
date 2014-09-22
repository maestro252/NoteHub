class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :token
      t.date :expires
      t.integer :user_id

      t.timestamps
    end
    add_index :auths, ['user_id'], name: 'auths_index_user_id', unique: true
  end
end
