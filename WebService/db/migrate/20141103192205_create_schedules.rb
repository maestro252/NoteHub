class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :course_id
      t.string :weekday
      t.time :time
      t.string :classroom

      t.timestamps
    end
  end
end
