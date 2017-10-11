module PhotosHelper


#  Function to return true 
	def owns_photo?(photo)


		if !user_signed_in?
			return false
		end

		if current_user.id != photo.user_id
			return false
		end

		return true
	end
end
