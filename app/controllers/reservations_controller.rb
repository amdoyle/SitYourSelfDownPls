class ReservationsController < ApplicationController
  before_action :load_restaurant, only: [:new, :edit, :create, :update]
  before_action :ensure_logged_in, only: [:create, :destroy]
  before_action :load_reservation, only: [:show, :destroy]


  def new
    @reservation = Reservation.new
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @restaurant.available?(params[:reservation][:number], params[:reservation][:time], @reservation)
      if @reservation.update_attributes(reservation_params)
        redirect_to restaurant_path(@reservation.restaurant_id), notice: "Reservation has been updated! #{@reservation.time}"
      else
        redirect_to edit_restaurant_reservation_path(@restaurant, @reservation), notice: "Problem updating reservation"
      end
    else
      redirect_to edit_restaurant_reservation_path(@restaurant, @reservation), notice: "No space for that reservation then"
    end
  end

  def create
    if @restaurant.available?(params[:reservation][:number], params[:reservation][:time])
      @reservation = @restaurant.reservations.build(reservation_params)
      @reservation.user = current_user
      if @reservation.save
        redirect_to restaurant_path(@restaurant.id), notice: "Reservation has been created! #{@reservation.time}"
      else
        redirect_to reservations_path, notice: "Reservation failed to save to database."
      end
    else
      redirect_to restaurant_path(@restaurant.id), notice: "Sorry but the restaurant doesn't have available capacity at that time."
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.delete
      redirect_to reservations_path
    else
      redirect_to reservations_path, notice: "Something went wrong, not deleted"
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    @reservations = current_user.reservations.all
    @reservations = @reservations.sort_by{|r| r.time}
  end

  # Reservations nested under Restaurant, therefore using :restaurant_id
  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :number, :time, :comment)
  end

end
