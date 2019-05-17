class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :price
      t.integer :time_prep
      t.string :category

      t.timestamps
    end
  end
end
