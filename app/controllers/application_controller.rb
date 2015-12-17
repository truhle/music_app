class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_only
    unless current_user.admin?
      flash.alert = "Admin only"
      redirect_to root_url
    end
  end

  def admin?
    current_user.admin?
  end

  helper_method :admin?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  helper_method :current_user

  def logged_in?
    !current_user.blank?
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def must_be_logged_in
    unless logged_in?
      flash.notice = "Please log in"
      redirect_to root_url
    end
  end

  def save_previous_url
    session[:previous_url] = request.url
  end
end
