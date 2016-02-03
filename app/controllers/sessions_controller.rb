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
        render "new", notice: "Login is as owner failed"
      end
    elsif params[:user_type]=="user"

    end

  end

  def destroy
  end
end
