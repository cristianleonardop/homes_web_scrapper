json.extract! home, :id, :title, :address, :monthly_rent, :url, :created_at, :updated_at
json.url home_url(home, format: :json)
