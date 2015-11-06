class RootController < ApplicationController
  before_filter :check_authorized!

  def index; end

end
