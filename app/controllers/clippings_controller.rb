class ClippingsController < ApplicationController

  def synchronize_recent
    Incollage::SynchronizeRecentClippings.new(current_user_collection, instagram_client).execute
    redirect_to collage_builder_path
  end

  def synchronize_preceding
    Incollage::SynchronizePrecedingClippings.new(current_user_collection, instagram_client).execute
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

  def collection
    Incollage::ClippingsCollection.new(current_user.id, 1)
  end

  def collage_url(file)
    file.path.gsub(Rails.root.join('public').to_s,'')
  end

end
