class AuthController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => auth_callback_url)
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => auth_callback_url)
    authorize_access response.access_token
    redirect_to root_path
  end

  def logout
    restrict_access
    redirect_to root_path
  end

end
