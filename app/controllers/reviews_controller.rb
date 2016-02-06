class ReviewsController < ApplicationController

  before_action :load_restaurant


  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @restaurant.reviews.build(review_params)
      @review.user = current_user

    if @review.save
      redirect_to restaurant_path(@restaurant), notice:"Your review has been successfully saved"
    else
      redirect_to restaurant_path(@restaurant)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

private
    def review_params
      params.require(:review).permit(:comment, :rating, :user_id, :restaurant_id)
    end

    def load_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
