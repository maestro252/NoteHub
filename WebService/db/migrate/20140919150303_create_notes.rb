class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.date :date
      t.text :words
      t.text :lines
      t.integer :course_id

      t.timestamps
    end

    add_index :notes, ['course_id'], name: 'n_course_index', unique: false
  end
end
