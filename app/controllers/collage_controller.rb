class CollageController < ApplicationController
  before_filter :check_authorized!
  before_filter :init_current_stats

  def builder
    @clippings = all_clippings
  end

  protected

  def all_clippings
    options = {
        user_id: current_user.id,
        per_page: 10,
        page_number: 0,
    }

    Incollage::FindClippingsPage.new(options).execute
        .sort_by(&:external_created_time)
        .uniq(&:external_id).reverse
  end

end
