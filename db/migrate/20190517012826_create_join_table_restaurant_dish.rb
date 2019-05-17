class CreateJoinTableRestaurantDish < ActiveRecord::Migration[5.2]
  def change
    create_join_table :restaurants, :dishs do |t|
      # t.index [:restaurant_id, :dish_id]
      # t.index [:dish_id, :restaurant_id]
    end
  end
end
