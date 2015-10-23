class CollageController < ApplicationController
  before_filter :check_authorized!
  before_filter :init_current_stats

  def builder
    if params[:create_collage]
      create_collage
    else
      @clippings = all_clippings
    end
  end

  protected

  def create_collage
    @colors = params[:colors].split(?,)
    @clippings = Incollage::SearchClippingsForCollage.new({ user_id: current_user.id }, @colors, 4).execute

    collage_file = Incollage::MakeCollageFromClippings.new(@clippings[0..3], current_user.id).execute
    @collage = collage_url(collage_file)
  end

  def all_clippings
    options = {
        user_id: current_user.id,
        per_page: 9999,
        page_number: 0,
    }

    Incollage::FindClippingsPage.new(options).execute.uniq(&:external_id)
  end

  def collage_url(file)
    file.path.gsub(Rails.root.join('public').to_s,'')
  end

end
