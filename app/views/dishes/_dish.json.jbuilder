json.extract! dish, :id, :name, :price, :time_prep, :category, :created_at, :updated_at
json.url dish_url(dish, format: :json)
