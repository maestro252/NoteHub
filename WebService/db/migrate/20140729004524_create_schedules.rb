class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :course_id
      t.string :weekday
      t.time :time
      t.string :classroom
      t.string :recurrence

      t.timestamps
    end

    add_index :schedules, ['course_id'], name: 'course_index'
  end
end
