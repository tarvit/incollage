class AuthController < ApplicationController

  class InstagramConnector
    attr_reader :redirect_uri

    def initialize redirect_uri
      @redirect_uri = redirect_uri
    end

    def authorize_url
      ::Instagram.authorize_url(:redirect_uri => redirect_uri)
    end

    def get_access_token(code)
      ::Instagram.get_access_token(code, :redirect_uri => redirect_uri).access_token
    end

  end

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
