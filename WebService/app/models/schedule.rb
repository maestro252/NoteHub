class Schedule < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :course
  validates_presence_of :weekday
  validates_presence_of :time
  validates_presence_of :recurrence

end
