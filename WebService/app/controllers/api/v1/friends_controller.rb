class Api::V1::FriendsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  before_action :authenticate!
  
  def create
      @friend = Friends.new create_params
      if @friend.save
        render json: {success: true, friend: @friend}
      else
        render json: {success: false, errors: @friend.errors}
      end
  end

  def index

  end

  def show


  end

  def destroy


  end

  def update

  end

  private
    def create_params
        params.require(:friends).permit(:user_id, :username)
    end
end
