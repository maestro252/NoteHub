class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.date :start
      t.date :end
      t.integer :user_id

      t.timestamps
    end

    add_index :courses, ['user_id'], name: 'c_user_index'
  end
end
