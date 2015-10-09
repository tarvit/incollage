class CollageController < ApplicationController
  before_filter :check_authorized!

  def builder
    @images = instagram_client.user_media_feed.map{|item| item.images.low_resolution.url}
  end

end
