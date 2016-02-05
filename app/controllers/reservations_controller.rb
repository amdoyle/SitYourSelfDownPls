class ReservationsController < ApplicationController
  before_action :load_restaurant, only: [:new, :create, :destroy, :edit]

  def new
    @reservation = Reservation.new
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create

    @restaurant.available?(params[:reservation][:number], params[:reservation][:time])
    # @reservation = @restaurant.reservations.build(reservation_params)
    # @reservation.user = current_user
    # if @reservation.save
    #   redirect_to restaurant_path(@reservation.restaurant_id), notice: "Reservation has been created! #{@reservation.time}"
    # else
    #   render "new"
    # end
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
  end

  # Reservations nested under Restaurant, therefore using :restaurant_id
  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :number, :time)
  end

end
