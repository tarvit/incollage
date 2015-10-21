class InstagramMediaClipping
  attr_reader :media_item, :user_clippings_collection

  def initialize(media_item, user_clippings_collection)
    @media_item = media_item
    @user_clippings_collection = user_clippings_collection
  end

  def to_entity_attrs
    url = make_picture_url
    {
        user_id: user_clippings_collection.user_id,
        external_id: media_item.id,
        linked_account_id: user_clippings_collection.linked_account_id,
        external_created_time: media_item.created_time,
        collection_id: user_clippings_collection.collection_id,
        picture_url: url,
        histogram: make_histogram(url),
    }
  end

  protected

  def make_histogram(url)
    file = Incollage::Service.for_collage_filestorage.save_clipping(url, media_item.id)
    histogram_maker = Incollage::Service.for_histogram_maker_factory.get(file.path)
    histogram_maker.make
  end

  def make_picture_url
    media_item.images.low_resolution.url
  end

end
