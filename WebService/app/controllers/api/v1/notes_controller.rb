class Api::V1::NotesController < ApplicationController
	
	skip_before_filter :verify_authenticity_token
	respond_to :json
	before_action :authenticate!

	def index
		notes = Note.all
		render json:notes
	end

	def create

	end

	def update 

	end

	def destroy

	end

	def show

	end

end
