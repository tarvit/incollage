class CollageController < ApplicationController
  before_filter :check_authorized!

  def builder
    @clippings= []
    # @page = params[:page].to_i
    # #clippings = Incollage::FindClippingsPage.new(current_user.id, DEFAULT_COLLECTION_ID, @page, PER_PAGE).execute
    # clippings = Incollage::ClippingsFinder.new(current_user_collection).find_all
    # @clippings = clippings.sort_by(&:external_created_time).reverse
  end

end
