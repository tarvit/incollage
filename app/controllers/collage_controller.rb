class CollageController < ApplicationController
  before_filter :check_authorized!

  DEFAULT_COLLECTION_ID = 1
  PER_PAGE = 100

  def builder
    @page = params[:page].to_i
    clippings = Incollage::FindClippingsPage.new(current_user.id, DEFAULT_COLLECTION_ID, @page, PER_PAGE).execute
    @images = clippings.map &:file_path
  end

end
