class InstagramClippingsSource

  class Base

    def initialize(instagram_client)
      @client = instagram_client
    end

    def next_clippings(collection, last_clipping)
      new_items(last_clipping.try(:external_id)).map do |item|
        InstagramMediaClipping.new(item, collection).to_entity
      end
    end

    def new_items(external_id)
      raise NotImplementedError
    end

  end

  class Recent < Base
    def new_items(external_id)
      @client.user_media_feed( min_id: external_id )
    end

    alias_method :recent_clippings, :next_clippings
  end

  class Preceding < Base
    def new_items(external_id)
      @client.user_media_feed(max_id: external_id)
    end

    alias_method :preceding_clippings, :next_clippings
  end


end
