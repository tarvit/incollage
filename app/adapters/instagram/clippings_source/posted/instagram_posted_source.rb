module InstagramClippingsSource

  class PostedMediaSource < Base

    def recent_clippings(collection, external_id, context)
      feed_response(collection, context, min_id: external_id)
    end

    def preceding_clippings(collection, external_id, context)
      feed_response(collection, context, max_id: external_id)
    end

    protected

    def feed(client, options={})
      client.user_recent_media(user_id(client), options)
    end

    def user_id(client)
      @user_id ||= client.user.id
    end
  end
end
