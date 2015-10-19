module ApplicationControllerSession

  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def user_session
    Incollage::UserSession.new(session)
  end

  def current_user
    user_session.current_user
  end

  def check_authorized!
    redirect_to auth_login_path unless user_session.authorized?
  end

end
