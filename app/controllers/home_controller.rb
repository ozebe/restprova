class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @dishes = if params[:term]
                Dish.where('category LIKE ?', "%#{params[:term]}%")
              else
                Dish.all
              end
  end
end


