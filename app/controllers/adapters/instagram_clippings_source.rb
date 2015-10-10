class InstagramClippingsSource

  def initialize(instagram_client)
    @client = instagram_client
  end

  def next_clippings(collection, last_clipping)
    feed = @client.user_media_feed(max_id: last_clipping.try(:external_id))
    puts ?-*100
    puts feed.count
    feed.map do |item|
      InstagramMediaClipping.new(item, collection).to_entity
    end
  end

  class InstagramMediaClipping

    attr_reader :media_item, :collection

    def initialize(media_item, collection)
      @media_item = media_item
      @collection = collection
    end

    def to_entity
      {
          user_id: collection.user_id,
          external_id: media_item.id,
          external_created_time: media_item.created_time,
          collection_id: collection.id,
          file_path: make_file_path,
          histogram: make_histogram,
      }
    end

    protected

    def make_histogram
      Incollage::Histogram.new(1 => '00ff00')
    end

    def make_file_path
      media_item.images.low_resolution.url
    end
  end

end
