class Api::V1::NotesController < ApplicationController

	skip_before_filter :verify_authenticity_token
	respond_to :json
	before_action :authenticate!

	def index
		has_many = false

		if params[:search]
			course = Note.where ["tags LIKE ?", "%#{params[:search]}%"]
			has_many = true
		else
			course = Course.find_by id: params[:id], user: current_user
		end
	  #	puts course

		if course
			unless has_many
				render json: course.notes
			else
				render json: course
			end
		else
			unauthorized
		end
	end

	def create
		course = Course.find_by id: params[:id], user: current_user

		if course
			@note = Note.new create_params

			@note.course_id = course.id
			@note.published = false
			if @note.save!
				render json: { success: true, note: @note }
			else
				render json: { success: false, errors: @note.errors }
			end
		else
			unauthorized
		end
	end

	def update
		course = Course.find_by id: params[:id], user: current_user

		if course
			@note = Note.find params[:note_id]

			@note.update create_params
			@note.course_id = course.id

			if @note.save!
				render json: { success: true, note: @note }
			else
				render json: { success: false, errors: @note.errors }
			end
		else
			unauthorized
		end
	end

	def destroy

	end

	def show
			@note = Note.find params[:id]

			render json:{success: true, note: @note}
	end

	private
		def create_params
			params.require(:note).permit(:title, :date, :words, :lines, :pattern, :tags, :published)
		end

		def unauthorized
			render json: { success: false, errors: ['Solo puede ver sus notas'] }, status: 401
		end

end
