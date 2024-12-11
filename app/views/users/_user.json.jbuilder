json.extract! user, :id, :firstName, :lastName, :userName, :password, :type, :created_at, :updated_at
json.url user_url(user, format: :json)
