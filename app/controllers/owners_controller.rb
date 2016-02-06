class OwnersController < ApplicationController

  before_action :authorize,:only => [:edit, :destroy, :show]

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      redirect_to owner_path(@owner.id), notice: "Signed up as owner!"
    else
      render "new"
    end
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(owner_params)
      redirect_to owner_path(@owner.id)
    else
      redirect_to edit_owner_path(@owner.id), notice: "Failed to save changes"
    end
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
  end

  private
  def owner_params
    params.require(:owner).permit(:username, :email, :password, :password_confirmation)
  end

  def authorize
    @restaurant = Resturant.find(params[:id])
      if !@restaurant.owner_id == current_owner.id
        flash[:notice] = "You can't edit this content."
      end
  end
end
