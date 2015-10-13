class CollageController < ApplicationController
  before_filter :check_authorized!

  DEFAULT_COLLECTION_ID = 1
  PER_PAGE = 1000

  def builder
    @page = params[:page].to_i
    #clippings = Incollage::FindClippingsPage.new(current_user.id, DEFAULT_COLLECTION_ID, @page, PER_PAGE).execute
    clippings = Incollage::ClippingsFinder.new(Incollage::ClippingsCollection.new(current_user.id, DEFAULT_COLLECTION_ID)).find_all
    @clippings = clippings.sort_by(&:external_created_time).reverse
  end

end
