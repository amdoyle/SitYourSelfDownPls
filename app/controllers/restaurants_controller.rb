class RestaurantsController < ApplicationController

  before_action :ensure_owner, only: [:create, :edit, :update, :create]

  def index
    @restaurants = Restaurant.all
    @categories = Category.all

    if params[:search]
      @restaurants = Restaurant.search(params[:search])
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    @restaurant = Restaurant.new
    @categories = Category.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
      @restaurant.owner = current_owner

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reservation = @restaurant.reservations.build

    if current_user
      @review = @restaurant.reviews.build
    end

    @reservations = @restaurant.reservations
    start_time = Time.now.beginning_of_hour
    end_time = start_time + 7.days

    i_time = start_time
    @unavailable_times = []
    while i_time <= end_time
      available_capacity = @restaurant.available_capacity_at_hour(i_time)
      if available_capacity == 0
        @unavailable_times << i_time
      end
      i_time += 1.hours
    end

  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @categories = Category.all
  end

  def update
    @restaurant = Restaurant.find(params[:id])

      if @restaurant.update_attributes(restaurant_params)
          redirect_to restaurant_path(@restaurant)
      else
          redirect_to
      end

  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number,
    :picture, :description, :capacity, :opening_time, :closing_time, :category_id, :owner_id )
  end



end
