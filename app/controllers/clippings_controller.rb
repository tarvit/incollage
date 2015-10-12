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
      url = img.picture_url
      fname = img.id
      Incollage::Gateway.for_downloader.download(url, "image_#{fname}").path
    end
  end

  def collage_path
    Rails.root.join("public/fs/#{Rails.env}/collages/#{current_user.id}_#{rand(99999)}.png")
  end

  def collage_url(file)
    file.path.gsub(Rails.root.join('public').to_s,'')
  end

end
