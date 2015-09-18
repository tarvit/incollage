class AuthController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => auth_callback_url)
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => auth_callback_url)
    authorize response.access_token
    redirect_to root_path
  end

end
