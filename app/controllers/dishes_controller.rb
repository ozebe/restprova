class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  # GET /dishes
  # GET /dishes.json
  def index
    @dishes = Dish.order(:name)
    @dishes = if params[:term]
                Dish.where('category LIKE ?', "%#{params[:term]}%")
              else
                Dish.all
              end
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.new(dish_params)

    params[:ingredient][:ingredient_ids].each do |ingredient_id|
      unless ingredient_id.empty?
        ingredient = Ingredient.find(ingredient_id)
        @dish.ingredients << ingredient
      end
    end

    params[:restaurant][:restaurant_id].each_line do |restaurant_id|
        restaurant = Restaurant.find(restaurant_id)
        @dish.restaurants << restaurant
    end

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: 'Prato adicionado!' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    @dish.ingredients.clear
    params[:ingredient][:ingredient_ids].each do |ingredient_id|
      unless ingredient_id.empty?
        ingredient = Ingredient.find(ingredient_id)

        @dish.ingredients << ingredient
      end
    end

    @dish.restaurants.clear
    params[:restaurant][:restaurant_id].each_line do |restaurant_id|
      restaurant = Restaurant.find(restaurant_id)
      @dish.restaurants << restaurant
    end


    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Prato atualizado!' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_url, notice: 'Prato apagado!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:name, :price, :time_prep, :category, :term)
    end
end
