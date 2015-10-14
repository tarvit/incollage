module InstagramClippingsSource

  class ReceivedMediaSource < Base

    def recent_clippings(collection, external_id)
      feed_response(collection, min_id: external_id)
    end

    def preceding_clippings(collection, external_id)
      feed_response(collection, max_id: external_id)
    end

    protected

    def feed(options={})
      @client.user_media_feed(options)
    end

  end
end
