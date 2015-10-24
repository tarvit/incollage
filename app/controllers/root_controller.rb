class RootController < ApplicationController
  before_filter :check_authorized!

  def index
    #redirect_to collage_builder_path
  end

end
