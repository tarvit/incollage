module ApplicationControllerCurrentUser

  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    user = instagram_client.user
    data = { full_name: user.full_name, username: user.username }
    @current_user = Incollage::FindOrCreateUser.new(data).execute
  end

end
