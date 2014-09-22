class Api::V1::UsersController < ApplicationController

	skip_before_filter :verify_authenticity_token
	respond_to :json

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

	private
	def login_params
		params.require(:user).permit(:key, :password)
	end
end
