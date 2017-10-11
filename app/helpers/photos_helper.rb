module PhotosHelper
	# Method returns true if you pass all the conditions.
	def owns_photo?(photo)

		# are you signed in?
		if !user_signed_in?
			return false
		end

		# does your Id match the photo creator id
		if current_user.id != photo.user_id
			return false
		end

		# okay return true
		return true
	end
end
