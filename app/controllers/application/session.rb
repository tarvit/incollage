module ApplicationControllerSession

  def authorized?
    !!session[:access_token]
  end

  def authorize_access(access_token)
    session[:access_token] = access_token
  end

  def restrict_access
    session[:access_token] = nil
  end

  def access_token
    session[:access_token]
  end

  def check_authorized!
    redirect_to auth_login_path unless authorized?
  end

  protected

  def instagram_client
    @client ||= ::Instagram.client(:access_token => access_token)
  end

end
