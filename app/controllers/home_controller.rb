class HomeController < ApplicationController
  def index
    #é criado a consulta sql que verifica se o restaurante possui algum prato com a categoria passada por get
    @restaurants = Restaurant.all
    @restaurants = @restaurants.distinct()
    @restaurants = @restaurants.joins("INNER JOIN dishes_restaurants AS drs
    ON restaurants.id = drs.restaurant_id INNER JOIN dishes AS di ON drs.dish_id = di.id")

    @restaurants = if params[:term]
                     @restaurants.where('UPPER (di.category) LIKE ? ', "#{params[:term].upcase}%").distinct

              else
                @restaurants.all
              end
  end



end


