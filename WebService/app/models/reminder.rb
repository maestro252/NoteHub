class Reminder < ActiveRecord::Base
	belongs_to :user
	validates_presence_of [:title, :deadline]
end
