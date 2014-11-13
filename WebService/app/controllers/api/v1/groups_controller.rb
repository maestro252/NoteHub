class Api::V1::GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :authenticate!, except: [:index]

  def create
    @group = Group.new create_params
    @group.admin = current_user.id
    if @group.save
      render json:{success: true, group: @group}
    else
      render json:{success: false, errors: @group.errors}
    end
  end

  def index
    @groups = Usergroup.where user: current_user
    render json:{success: true, groups: @groups}, include: :group 
  end

  def show

  end

  def update

  end

  def destroy

  end

  private
    def create_params
      params.require(:group).permit(:name,:admin)
    end
end
