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

    class InstagramMediaClipping
      require 'open-uri'
      attr_reader :media_item, :collection

      def initialize(media_item, collection)
        @media_item = media_item
        @collection = collection
      end

      def to_entity
        path = make_picture_url
        {
            user_id: collection.user_id,
            external_id: media_item.id,
            external_created_time: media_item.created_time,
            collection_id: collection.id,
            picture_url: path,
            histogram: make_histogram(path),
        }
      end

      protected

      def make_histogram(url)
        puts url
        file = save_to_tempfile(url, "instagram_media_#{media_item.id}")
        Incollage::HistogramMaker.new(file.path).make
      end

      def make_picture_url
        media_item.images.low_resolution.url
      end

      def save_to_tempfile(url, filename)
        uri = URI.parse(url.gsub('https://', 'http://'))
        Net::HTTP.start(uri.host, uri.port) do |http|
          resp = http.get(uri.path)
          file = Tempfile.new(filename, Dir.tmpdir, 'wb+')
          file.binmode
          file.write(resp.body)
          file.flush
          file
        end
      end
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
