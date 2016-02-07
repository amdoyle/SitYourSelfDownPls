class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:user_type]=="owner"
      owner = Owner.find_by(email: params[:email])
      if owner && owner.authenticate(params[:password])
        session[:owner_id] = owner.id
        redirect_to owner_path(owner.id), notice: "Logged in as owner!"
      else
        redirect_to new_session_path, notice: "Login is as owner failed"
      end
    elsif params[:user_type]=="user"
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user.id), notice: "Logged in as user!"
      else
        redirect_to new_session_path, notice: "Login is as user failed"
      end
    else
      redirect_to new_session_path, notice: "Please select owner or user."
    end
  end

  def destroy
    session[:user_id] = nil
    session[:owner_id] = nil
    current_user = nil
    current_owner = nil
  end
end
