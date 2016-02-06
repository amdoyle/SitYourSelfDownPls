class UsersController < ApplicationController

before_action :load_user, only: [:edit, :update, :destroy, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice:'Welcome to Sit Yourself Down, Please'
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def show

  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def load_user
    @user = User.find(params[:id])
  end

end
