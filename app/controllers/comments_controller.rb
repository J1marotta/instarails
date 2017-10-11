class CommentsController < ApplicationController
	def index
		@photo = Photo.find(params[:photo_id])
		@comments = @photo.comments
		@comment = Comment.new
	end
end
