class Api::V1::UsersController < ApplicationController

	skip_before_filter :verify_authenticity_token
	respond_to :json

	def create
		@user = User.create register_params

		if @user.save
			render json: {success:true, user:@user}, except: [:password, :salt]
		else
			render json: {success:false, errors:@user.errors}
		end

	end

	def update
		if true
			@user = User.find_by id: current_user.id
			@user.update update_params

			if @user.save
				render json: {success:true, user: @user}
			else
				render json: {success: false, errors: @user.errors}
			end
		else
			render json: {success:false, errors:["Solo puede cambiar SU descripcion"]}, status: 401
		end
	end

	def login
		login = Auth.authenticate(login_params[:key], login_params[:password])
		if login
			render json:{success:true, auth: {token:login.token, expires:login.expires},
						user:login.user}, except: [:password_encrypted, :salt]
		else
			render json:{succes:false, errors: ['Nombre de usuario o contraseña inválido']},
						status:401
		end
	end

	def user_id_by_username
		x = User.find_by username: params[:id]
		render json:{success: true, user: x }, except: [:username, :email, :name, :active, :password_encrypted, :salt,
		:created_at, :updated_at, :description]

	end

	private
		def login_params
			params.require(:user).permit(:key, :password)
		end

		def register_params
			params.require(:user).permit(:name, :username,
				:email, :password)
		end

		def update_params
			params.require(:user).permit(:description)
		end
end
