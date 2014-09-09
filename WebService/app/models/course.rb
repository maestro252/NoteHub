class Course < ActiveRecord::Base
  has_many :schedules, dependent: :delete_all
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :start
  validates_presence_of :end
  validates_presence_of :name

end
