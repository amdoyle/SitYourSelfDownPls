class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_owner
    @current_owner ||= Owner.find(session[:owner_id]) if session[:owner_id]
  end

  helper_method :current_user
  helper_method :current_owner

end
