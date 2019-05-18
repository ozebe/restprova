class Dish < ApplicationRecord
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :restaurants
  validates_presence_of :name, :price, :time_prep, :category
end
