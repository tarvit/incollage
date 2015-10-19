class ClippingsController < ApplicationController
  before_filter :check_authorized!

  def synchronize_recent
    Incollage::SynchronizeRecentClippings.new(current_user_collection, context).execute
    redirect_to collage_builder_path
  end

  def synchronize_preceding
    Incollage::SynchronizePrecedingClippings.new(current_user_collection, context).execute
    redirect_to collage_builder_path
  end

  def search
    colors = params[:colors].split(?,)
    clippings = Incollage::SearchClippingsForCollage.new(current_user_collection, colors, 4).execute
    @clippings = clippings.sort_by(&:external_id)

    collage_file = Incollage::MakeCollageFromClippings.new(@clippings, current_user.id).execute
    @collage = collage_url(collage_file)

    render 'collage/builder'
  end

  protected

  def collage_url(file)
    file.path.gsub(Rails.root.join('public').to_s,'')
  end

  def context
    { instagram_client: instagram_client }
  end

end
