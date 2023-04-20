json.extract! photo, :id, :url, :user_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)
