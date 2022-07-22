json.extract! owned_stock, :id, :user_id, :ticker, :shares_owned, :total_cost, :created_at, :updated_at
json.url owned_stock_url(owned_stock, format: :json)
