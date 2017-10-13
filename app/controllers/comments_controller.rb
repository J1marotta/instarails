class CommentsController < ApplicationController

	#  Define our set action in private but do it before we trigger any other methods, so we don't get 'nil' errors
	before_action :set_photo, only: [:create, :destroy]


	def index
		@photo = Photo.find(params[:photo_id])
		@comments = @photo.comments
		@comment = Comment.new
	end

	def create
		# define our comment to match a photo
		@comment = @photo.comments

		#new a comment instance = "a new comment with comment paramaters"
		@new_comment = Comment.new(comment_params)

		# devise set comment user to current user
		@new_comment.user = current_user
		#  set our relationship to photo
		@new_comment.photo = @photo


		# save the comment
		@new_comment.save!

		# go back and show comments
		redirect_to photo_comments_path(@photo)

	end

	def edit
	end

	def update
	end

	def destroy
		@comment = @photo.comments.find(params[:id])
		@comment.destroy
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

		def comment_params
			params.require(:comment).permit(:content, :photo_id, :user_id)
		end


end
