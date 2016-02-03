class OwnersController < ApplicationController
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
      render :edit
    end

  end

  private
  def owner_params
    params.require(:owner).permit(:username, :email, :password, :password_confirmation)
  end
end
