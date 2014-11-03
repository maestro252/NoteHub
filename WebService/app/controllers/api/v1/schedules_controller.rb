class Api::V1::SchedulesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :authenticate!
  def index

  end

  def create
    @schedule = Schedule.new create_params
    if @schedule.save
      render json: {success: true, schedule: @schedule}
    else
      render json: {success: false, errors: @schedule.errors}
    end
  end

  def update

  end

  def destroy

  end

  def show
    @schedules = Schedule.where course_id: params[:id]
    render json: {success: true, schedules:@schedules}
  end

  private
    def create_params
      params.require(:schedule).permit(:course_id, :weekday, :time, :classroom)
    end
end
