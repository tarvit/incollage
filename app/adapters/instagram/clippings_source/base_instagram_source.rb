module InstagramClippingsSource

  class Base
    def initialize(instagram_client)
      @client = instagram_client
    end

    def recent_clippings(collection, external_id)
      raise NotImplementedError
    end

    def preceding_clippings(collection, external_id)
      raise NotImplementedError
    end

    protected

    def feed(options={})
      raise NotImplementedError
    end

    def feed_response(collection, options)
      feed(options).map do |item|
        InstagramMediaClipping.new(item, collection).to_entity_attrs
      end
    end

  end

end
