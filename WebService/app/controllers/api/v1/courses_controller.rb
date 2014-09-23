class Api::V1::CoursesController < ApplicationController
	skip_before_filter :verify_authenticity_token
	respond_to :json

	before_action :authenticate!

	def index 
		@courses = Course.find_by user: current_user

		render json: @courses
	end

	def show
	end

	def destroy
	end

	def update
	end

	def create 
	end

	def notes
	end
end
