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

  def ensure_logged_in
    unless current_user
      redirect_to new_session_url, alert: "You to be logged in to perform this action"
    end
  end

private

def authorize
  if current_owner
    @restaurant = Restaurant.find(params[:id])
      if @restaurant.owner_id == current_owner

      elsif @restaurant.owner_id != current_owner
        redirect_to restaurants_path, notice: "You can only edit your own restaurant pages."
      else
        redirect_to sessions_path
      end
  elsif current_user
  else
  end
end

end
