class AuthController < ApplicationController
  require Rails.root.join 'app/controllers/auth/instagram_connector'

  def connect
    redirect_to InstagramConnector.new(auth_callback_url).authorize_url
  end

  def callback
    access_token = InstagramConnector.new(auth_callback_url).get_access_token(params[:code])
    authorize_access access_token
    redirect_to root_path
  end

  def logout
    restrict_access
    redirect_to root_path
  end

end
