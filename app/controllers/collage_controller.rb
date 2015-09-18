class CollageController < ApplicationController
  before_filter :check_authorized!

  def builder
    @client = Instagram.client(:access_token => access_token)
  end

end
