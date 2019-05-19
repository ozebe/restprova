class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    #é criado a consulta sql que verifica se o restaurante possui algum prato com a categoria passada por get
  @restaurants = Restaurant.all.order(:name)
    @restaurants = @restaurants.distinct()
    @restaurants = @restaurants.joins("INNER JOIN dishes_restaurants AS drs
    ON restaurants.id = drs.restaurant_id INNER JOIN dishes AS di ON drs.dish_id = di.id")

    @restaurants = if params[:term]
                     @restaurants.where('UPPER (di.category) LIKE ? ', "#{params[:term].upcase}%").distinct

                   else
                     @restaurants.all
                   end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @dishes = Dish.all
    #é criada a união das tabelas para conseguirmos pegar os dados delas
    @dishes = @dishes.joins("INNER JOIN dishes_restaurants AS dr ON dishes.id = dr.dish_id INNER JOIN restaurants AS r
    ON dr.restaurant_id = r.id")
    @dishes = @dishes.where("r.id = " + params[:id])

    #pesquisa feita quando é mandado por get a categoria
    @dishes = if params[:term]
                @dishes = @dishes.joins("INNER JOIN dishes_restaurants AS dr2 ON dishes.id = dr2.dish_id INNER JOIN restaurants AS r2
                ON dr2.restaurant_id = r2.id")
                @dishes = @dishes.where("r.id = " + params[:id])
                @dishes = @dishes.where('UPPER (category) LIKE ? ', "#{params[:term].upcase}%")

#se não for encontrado ele mostra as dishes do restaurante escolhido
              else
                @dishes = @dishes.joins("INNER JOIN dishes_restaurants AS dr3 ON dishes.id = dr3.dish_id INNER JOIN restaurants AS r3
    ON dr3.restaurant_id = r3.id")
                @dishes = @dishes.where("r.id = " + params[:id])
              end
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
    @restaurants = Restaurant.all.order(:name)
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html {redirect_to @restaurant, notice: 'Restaurant was successfully created.'}
        format.json {render :show, status: :created, location: @restaurant}
      else
        format.html {render :new}
        format.json {render json: @restaurant.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html {redirect_to @restaurant, notice: 'Restaurant was successfully updated.'}
        format.json {render :show, status: :ok, location: @restaurant}
      else
        format.html {render :edit}
        format.json {render json: @restaurant.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html {redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :telephone, :address, :term)
  end
end
