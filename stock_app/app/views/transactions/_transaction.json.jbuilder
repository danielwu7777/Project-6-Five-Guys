json.extract! transaction, :id, :ticker, :action, :shares, :time, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
