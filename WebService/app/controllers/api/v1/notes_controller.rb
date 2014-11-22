class Api::V1::NotesController < ApplicationController

	skip_before_filter :verify_authenticity_token
	respond_to :json
	before_action :authenticate!, except: [:index]

def index
	has_many = false

	if params[:friends]
		friends = Friend.where user_id: current_user.id

		@notes = Note.where published: true
		@notes2 = []
		@notes.each do |x|
			usrname = x.username
			friends.each do |y|
				if y.username == usrname
					@notes2 << x
				end
			end
		end
		p @notes2
		render json: {success: true, notes: @notes2}
	else
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
end

	def create
		course = Course.find_by id: params[:id], user: current_user
		ok = false
		ok = true if params[:id] == 0
		if course || ok
			@note = Note.new create_params
			@note.username = current_user.username
			@note.course_id = course.id
			@note.published = false
			if @note.save!
				render json: { success: true, note: @note }
			else
				render json: { success: false, errors: @note.errors }
			end
		else
			@note = Note.new create_params
			@note.username = current_user.username
			@note.course_id = 0
			@note.published = false
			if @note.save!
				render json: { success: true, note: @note }
			else
				render json: { success: false, errors: @note.errors }
			end
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
			params.require(:note).permit(:title, :date, :words, :lines, :pattern, :tags, :published, :group_id)
		end

		def unauthorized
			render json: { success: false, errors: ['Solo puede ver sus notas'] }, status: 401
		end

end
