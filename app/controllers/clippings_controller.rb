class ClippingsController < ApplicationController

  def synchronize_recent
    instagram_source = InstagramClippingsSource::Recent.new(instagram_client)
    Incollage::SynchronizeRecentClippings.new(collection, instagram_source).execute

    redirect_to collage_builder_path
  end

  def synchronize_preceding
    instagram_source = InstagramClippingsSource::Preceding.new(instagram_client)
    Incollage::SynchronizePrecedingClippings.new(collection, instagram_source).execute

    redirect_to collage_builder_path
  end

  def search
    colors = params[:colors].split(?,)
    clippings = Incollage::SearchClippingsForCollage.new(collection, colors, 4).execute
    @images = clippings.sort_by(&:external_id)

    collage_file = Incollage::MakeCollage.new(files(@images), collage_path).execute
    @collage = collage_url(collage_file)

    render 'collage/builder'
  end

  protected

  def collection
    Incollage::ClippingsCollection.new(current_user.id, 1)
  end

  def files(images)
    images.map do |img|
      Incollage::Gateway.for_collage_filestorage.save_clipping(img.picture_url, img.id).path
    end
  end

  def collage_path
    Incollage::Gateway.for_collage_filestorage.safe_collage_path(current_user.id)
  end

  def collage_url(file)
    file.path.gsub(Rails.root.join('public').to_s,'')
  end

end
