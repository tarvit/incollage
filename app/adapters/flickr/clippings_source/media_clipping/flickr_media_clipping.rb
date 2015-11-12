module FlickrAdapter
  class MediaClipping
    attr_reader :media_item, :user_clippings_collection

    def initialize(media_item, ucc)
      @media_item = media_item
      @user_clippings_collection = ucc
    end

    def to_entity_attrs
      {
          user_id: user_clippings_collection.user_id,
          linked_account_id: user_clippings_collection.linked_account_id,
          collection_id: user_clippings_collection.collection_id,
          external_id: media_item.id,
          picture: {
              url:  media_item.url_m,
              external_created_time: media_item.dateupload,
              histogram: make_histogram(media_item.url_m),
          }
      }
    end

    protected

    def make_histogram(url)
      Incollage::Service.for_histogram_maker.make(url)
    end

  end
end
