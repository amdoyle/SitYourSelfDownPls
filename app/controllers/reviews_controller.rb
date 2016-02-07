class ReviewsController < ApplicationController
  before_action :load_restaurant
  before_action :ensure_logged_in, only: [:create, :destroy]
  before_action :load_review, only: [:show, :destroy]

  def show
    @review.user = User.find(params[:user_id])
  end

  def create
    @review = @restaurant.reviews.build(review_params)
      @review.user = current_user

    if @review.save
      redirect_to restaurant_path(@restaurant), notice:"Your review has been successfully saved."
    else
      redirect_to restaurant_path(@restaurant), notice:"Your review has not been saved."
    end
  end

  def destroy
    @review.destroy
    redirect_to restaurant_path
  end

private
    def review_params
      params.require(:review).permit(:comment, :rating, :user_id, :restaurant_id)
    end

    def load_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def load_review
      @review = Review.find(params[:id])
    end
end
