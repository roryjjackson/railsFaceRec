json.extract! celebrity, :id, :name, :photo_url, :user_id, :created_at, :updated_at
json.url celebrity_url(celebrity, format: :json)
