class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.text :description
      t.string :recurrence
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

    add_index :events, ['user_id', 'date'], name: 'e_user_index', unique: false
  end
end
