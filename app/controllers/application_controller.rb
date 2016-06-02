class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user #2
  helper_method :logged_in? #3


  private #2

  def current_user #2
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in? #3
    !current_user.nil?
  end

  def login_user!(user) #4
    session[:session_token] = user.reset_session_token!
  end

  def logout_user! #5
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_user! #6
    redirect_to new_session_url if current_user.nil?
  end

  def require_no_user! #10
    redirect_to root_url if current_user
  end
end
