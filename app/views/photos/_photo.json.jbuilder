json.extract! photo, :current_user, :caption, :created_at, :updated_at
json.url photo_url(photo, format: :json)
