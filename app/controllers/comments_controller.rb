class CommentsController < ApplicationController
	def index
		@photo = Photo.find(@data[:photo].id)
		@comments = @photo.comments
		@comment = Comment.new
	end
end
