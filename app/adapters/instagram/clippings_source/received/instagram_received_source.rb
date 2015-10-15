module InstagramClippingsSource

  class ReceivedMediaSource < Base

    def recent_clippings(collection, recent_clipping, context)
      feed_response(collection, context, min_id: recent_clipping.try(:external_id))
    end

    def preceding_clippings(collection, preceding_clipping, context)
      feed_response(collection, context, max_id: preceding_clipping.try(:external_id))
    end

    protected

    def feed(client, options={})
      client.user_media_feed(options)
    end

  end
end
