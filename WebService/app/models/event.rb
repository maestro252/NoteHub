class Event < ActiveRecord::Base
	has_many :friends
	belongs_to :user
	
end
