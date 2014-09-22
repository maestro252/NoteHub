class Auth < ActiveRecord::Base
	belongs_to :user
	before_save :generate_token

	def self.authenticate(key, password)
		user = User.authenticate(key, password)
		if user
			token = Auth.new
			if Auth.exists?(user: user)
				token = Auth.find_by(user: user)
			end
			token.user_id = user.id
			return token if token.save!
		end
	end

	def valid_token?

		return self.expires >= DateTime.now
	end

	def rebuild_token
		generate_token 14
	end
	private
	def generate_token(timeLife = 360)
		begin
			self.token = SecureRandom.hex 64
		end while Auth.exists? token:self.token
		self.expires = DateTime.now + timeLife
	end
end
