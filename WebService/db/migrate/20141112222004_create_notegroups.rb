class CreateNotegroups < ActiveRecord::Migration
  def change
    create_table :notegroups do |t|
      t.integer :group_id
      t.integer :note_id

      t.timestamps
    end
  end
end
