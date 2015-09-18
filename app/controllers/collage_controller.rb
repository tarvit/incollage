class CollageController < ApplicationController
  before_filter :check_authorized!

  def builder
    @client = ::Instagram.client(:access_token => access_token)
    @images = @client.user_media_feed.map{|item| item.images.low_resolution.url}
  end

end
