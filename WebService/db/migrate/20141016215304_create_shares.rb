class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :note_id
      t.integer :user_id

      t.timestamps
    end
  end
end
