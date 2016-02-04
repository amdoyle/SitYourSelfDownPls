class ReservationsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_path(@reservation.id), notice: "Reservation has been created!"
    else
      render "new"
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

end
