class Note < ActiveRecord::Base
	belongs_to :course

	validates_inclusion_of :pattern, in: %w(stripped gridded plain)

	validates :title, presence: true 

end
