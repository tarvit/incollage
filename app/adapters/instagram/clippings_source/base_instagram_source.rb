module InstagramClippingsSource

  class Base

    def recent_clippings(user_clippings_collection, external_id, context)
      raise NotImplementedError
    end

    def preceding_clippings(user_clippings_collection, external_id, context)
      raise NotImplementedError
    end

    protected

    def feed(client, options={})
      raise NotImplementedError
    end

    def feed_response(user_clippings_collection, context, options)
      feed(instagram_client(context), options).map do |item|
        InstagramMediaClipping.new(item, user_clippings_collection).to_entity_attrs
      end
    end

    def instagram_client(context)
      context[:instagram_client]
    end

  end

end
