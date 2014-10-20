class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :user_id
      t.string :priority
      t.boolean :done

      t.timestamps
    end

    add_index :reminders, ['user_id', 'priority'], name: 'r_user_index', unique: false
  end
end
