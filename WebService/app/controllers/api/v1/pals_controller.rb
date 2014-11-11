class Api::V1::PalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :authenticate!

def create
  if User.all.exists? username: create_params[:username]
    @friend = Friend.new create_params
    if @friend.save
      render json: {success: true, friend: @friend}
      puts "Lo cree!"
    else
      render json: {success: false, errors: @friend.errors}
      puts "NO lo cree pero el usuario existe"
    end
  else
    render json: {success: false, errors: ["El nombre de usuario no existe"]}
    puts "No lo cree porque el usuario no existe"
  end
end
 

  private
    def create_params
      params.require(:friend).permit(:user_id, :username)
    end
end
