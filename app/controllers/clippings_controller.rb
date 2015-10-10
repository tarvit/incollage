class ClippingsController < ApplicationController

  def synchronize
    collection = Incollage::ClippingsCollection.new(current_user.id, 1)
    instagram_source = InstagramClippingsSource.new(instagram_client)
    Incollage::SynchronizeClippings.new(collection, instagram_source).sync
    redirect_to collage_builder_path
  end

end
