class CollageController < ApplicationController
  before_filter :check_authorized!

  def builder
    @current_user = execute_user
    @images = instagram_client.user_media_feed.map{|item| item.images.low_resolution.url}
  end

  private

  def instagram_client
    @client ||= ::Instagram.client(:access_token => access_token)
  end

  def execute_user
    user = instagram_client.user
    data = { full_name: user.full_name, username: user.username }
    Incollage::FindOrCreateUser.new(data).execute
  end

end
