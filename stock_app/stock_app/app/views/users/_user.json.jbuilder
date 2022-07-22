json.extract! user, :id, :username, :password, :name, :initialBalance, :currentBalance, :created_at, :updated_at
json.url user_url(user, format: :json)
