class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end

    add_index :friends, ['user_id'], name: 'f_user_index', unique: false
  end
end
