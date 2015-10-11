class ClippingsController < ApplicationController

  def synchronize
    collection = Incollage::ClippingsCollection.new(current_user.id, 1)
    instagram_source = InstagramClippingsSource.new(instagram_client)
    Incollage::SynchronizeClippings.new(collection, instagram_source).sync
    redirect_to collage_builder_path
  end

  def search
    collection = Incollage::ClippingsCollection.new(current_user.id, 1)
    colors = params[:colors].split(?,)
    clippings = Incollage::SearchClippingsForCollage.new(collection, colors, 5).execute
    @images = clippings.map &:picture_url
    @collage = @images.first

    render 'collage/builder'
  end

end
