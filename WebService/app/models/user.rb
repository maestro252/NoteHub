class User < ActiveRecord::Base
	@@email_regex = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

  has_many :courses

	alias_attribute :password, :password_encrypted
	alias_attribute :password_confirmation, :password_encrypted_confirmation

	before_save :encrypt_password
  before_save :formatter

  validates_presence_of [:email, :username, :password, :name], on: :create

	# Validar el nombre de usuario que cumpla
	# con las siguientes condiciones:
	#   *) Longitud entre 3 a 40 caracteres.
	#   *) Cumplir con la Regex definida para
	#      el username => (a-z A-Z 0-9 _ .)+

	validates :username,
            uniqueness: { case_sensitive: false },
		        length: { in: 3..40 },
		        format: { with: /\A[a-zA-Z0-9_.]+\z/ }

	# Validar el email para que cumpla con
	# las siguientes condiciones:
	#   *) Longitud minima 5 caracteres.
	#   *) Complir con la Regex [email_regex].
	#   *) Ser unico en la base de datos.

	validates :email,
            length: { minimum: 5 },
            format: { with: @@email_regex },
            uniqueness: { case_sensitive: false }

	# Validar el password -> password_encrypted
	# con las siguientes condiciones:
	#   *) Longitud minima 6 caracteres.
	#   *) Tener confirmacion: NO NECESARIO.

	validates :password_encrypted,
            length: { minimum: 6 },
            # Confirmacion de pass, password_confirmation
            # field, no se usara.
            confirmation: false

  def self.authenticate(key, password)
    if @@email_regex.match key
      user = User.find_by(email: key)
    else
      user = User.find_by(username: key)
    end

    if user && user.password_encrypted == User.encrypt(password, user.salt)
      return user
    end

    return nil
  end

  def self.encrypt(password, salt)
    Digest::SHA2.hexdigest("$$#{salt} ?< #{password}!$")
  end

	private
		def generate_salt
			self.salt = Digest::SHA2.hexdigest("$#{SecureRandom.hex 32} >? #{Time.now.utc}$")
		end

		def encrypt_password
			if password_encrypted_changed?
        generate_salt

        self.password_encrypted = User.encrypt(self.password_encrypted, self.salt)
      end
    end

    def formatter
      self.name.downcase!
    end
end
