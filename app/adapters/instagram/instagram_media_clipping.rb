class InstagramMediaClipping
  require 'open-uri'
  attr_reader :media_item, :collection

  def initialize(media_item, collection)
    @media_item = media_item
    @collection = collection
  end

  def to_entity
    path = make_picture_url
    {
        user_id: collection.user_id,
        external_id: media_item.id,
        external_created_time: media_item.created_time,
        collection_id: collection.id,
        picture_url: path,
        histogram: make_histogram(path),
    }
  end

  protected

  def make_histogram(url)
    file = Incollage::Gateway.for_downloader.download(url, "#{Dir.tmpdir}/instagram_media_#{media_item.id}")
    histogram_maker = Incollage::Gateway.for_histogram_maker_factory.new(file.path)
    histogram_maker.make
  end

  def make_picture_url
    media_item.images.low_resolution.url
  end

end
