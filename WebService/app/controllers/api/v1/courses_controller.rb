class Api::V1::CoursesController < ApplicationController
	skip_before_filter :verify_authenticity_token
	respond_to :json

	before_action :authenticate!

	def index
		@courses = Course.where user: current_user

		render json: @courses
	end

	def show
	end
	def destroy
	end

	def update
	end

	def create
		@course = Course.new create_params
		@course.user = current_user

		if @course.save
			render json:{success: true, course: @course}
		else
			render json:{success: false, errors: @course.errors}
		end
	end

	def notes
	end

	private

	def create_params
			params.require(:course).permit(:name, :description, :start, :end)
	end

end
