class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorized?
    !!session[:access_token]
  end

  def authorize(access_token)
    session[:access_token] = access_token
  end

  def access_token
    session[:access_token]
  end

  def check_authorized!
    redirect_to auth_login_path unless authorized?
  end

end
