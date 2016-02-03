class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice:'Welcome to Sit Yourself Down, Please'
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attirbutes(user_params)
      redirect_to users_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
  end



  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
