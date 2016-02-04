class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reservation = @restaurant.reservations.build
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update_attributes(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])

    @restaurant.destroy
    redirect_to owner_path(@owner.id)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name,:address, :phone_number,
    :picture, :description, :capacity, :opening_time, :closing_time)
  end

end
