module ApplicationControllerSession

  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def user_session
    Incollage::UserSession.new(session)
  end

  def current_user
    user_info = Incollage::GetUserInfo.new(user_session.current_user_id).execute
    TarvitHelpers::HashPresenter.present(user_info)
  end

  def check_authorized!
    redirect_to auth_login_path unless user_session.authorized?
  end

end
