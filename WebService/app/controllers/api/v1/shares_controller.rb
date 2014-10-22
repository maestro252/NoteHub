class Api::V1::SharesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    

  end
  def create
    @share = Share.new create_params
    if @share.save
      render json:{success: true, share: @share}
    else
      render json:{success: false, errors: @share.errors}
    end
  end

  private
  def create_params
    params.require(:share).permit(:note_id, :user_id)
  end
end
