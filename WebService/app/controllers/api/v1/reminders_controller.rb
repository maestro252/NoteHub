class Api::V1::RemindersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :authenticate!
  
  def create
    exc = false
    @reminder = Reminder.new create_params
    @reminder.user = current_user
    @reminder.done = false
    begin
      @reminder.deadline = DateTime.parse create_params[:deadline]
    rescue
      exc = true
      render json:{success: false, errors: ["Formato de fecha invalido"]}
    end
    if @reminder.save
      render json:{success: true, reminder: @reminder}
    elsif !exc
      render json:{success: false, errors: @reminder.errors}
    end
  end

  def index
    @reminders = Reminder.where user: current_user
    render json:{success: true, reminders: @reminders},
      except: [:priority, :description]


  end

  def destroy
    @reminder = Reminder.find params[:id]
    if @reminder.delete
      render json:{success: true}
    else
      render json:{success: false, errors: @reminder.errors}
    end
  end

  def update
      @reminder = Reminder.find params[:id]
      if @reminder.update update_params
        render json:{success: true, reminder: @reminder}
      else
        render json:{success: false, errors: @reminder.errors}
      end
  end

  private

    def create_params
      params.require(:reminder).permit(:deadline, :title, :description)
    end

    def update_params
      params.require(:reminder).permit(:done)
    end

end
