class Group < ActiveRecord::Base
  has_many :usergroup
  has_many :notegroup
end
