class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to new_owner_path, notice: "Signed up as owner!"
    else
      render "new"
    end
  end

  private
  def owner_params
    params.require(:owner).permit(:username, :email, :password, :password_confirmation)
  end
end
