module InstagramAdapter
  class MediaClipping
    attr_reader :media_item, :user_clippings_collection

    def initialize(media_item, user_clippings_collection)
      @media_item = media_item
      @user_clippings_collection = user_clippings_collection
    end

    def to_entity_attrs
      url = make_picture_url
      {
          user_id: user_clippings_collection.user_id,
          linked_account_id: user_clippings_collection.linked_account_id,
          collection_id: user_clippings_collection.collection_id,
          external_id: media_item.id,
          picture: {
              url: url,
              external_created_time: media_item.created_time,
              histogram: make_histogram(url),
          }
      }
    end

    protected

    def make_histogram(url)
      Incollage::Service.for_histogram_maker.make(url)
    end

    def make_picture_url
      media_item.images.low_resolution.url
    end

  end
end
