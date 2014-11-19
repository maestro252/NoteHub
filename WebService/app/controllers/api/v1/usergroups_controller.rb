class Api::V1::UsergroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :authenticate!, except: [:index]
  def create
    @usergroup = Usergroup.new create_params
    @usergroup.group_id = Group.last.id
    if @usergroup.save
      render json:{success: true, usergroup: @usergroup}
    else
      render json:{success: false, errors: @usergroup.errors}
    end
  end


  private
    def create_params
      params.require(:usergroup).permit(:user_id, :group_id)
    end
end
