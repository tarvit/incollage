class ClippingsController < ApplicationController

  def synchronize
    collection = Incollage::ClippingsCollection.new(current_user.id, 1)

    instagram_source = InstagramClippingsSource::Recent.new(instagram_client)
    Incollage::SynchronizeRecentClippings.new(collection, instagram_source).execute

    # instagram_source = InstagramClippingsSource::Preceding.new(instagram_client)
    # Incollage::SynchronizePrecedingClippings.new(collection, instagram_source).execute

    redirect_to collage_builder_path
  end

  def search
    collection = Incollage::ClippingsCollection.new(current_user.id, 1)
    colors = params[:colors].split(?,)
    clippings = Incollage::SearchClippingsForCollage.new(collection, colors, 5).execute
    @images = clippings.sort_by(&:external_id)
    @collage = @images.first

    render 'collage/builder'
  end

end
