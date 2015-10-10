class InstagramClippingsSource

  def initialize(instagram_client)
    @client = instagram_client
  end

  def next_clippings(collection, last_clipping)
    feed = last_clipping.nil? ? whole_collection_items : new_items(last_clipping.external_id)

    entities = feed.map do |item|
      InstagramMediaClipping.new(item, collection).to_entity
    end

    entities.sort_by{|x| x[:external_created_time] }
  end

  def new_items(external_id)
    @client.user_media_feed( min_id: external_id )
  end

  def whole_collection_items
    items = []
    current_page = @client.user_media_feed
    items << current_page
    next_max_id = current_page.pagination.next_max_id
    puts items.count
    puts next_max_id

    while next_max_id
      current_page = @client.user_media_feed(max_id: next_max_id)
      items << current_page
      next_max_id = current_page.pagination.next_max_id
      puts items.count
      puts next_max_id
    end

    puts ?-*100
    items.flatten(1)
  end

  class InstagramMediaClipping
    require 'open-uri'
    attr_reader :media_item, :collection

    def initialize(media_item, collection)
      @media_item = media_item
      @collection = collection
    end

    def to_entity
      path = make_file_path
      {
          user_id: collection.user_id,
          external_id: media_item.id,
          external_created_time: media_item.created_time,
          collection_id: collection.id,
          file_path: path,
          histogram: make_histogram(path),
      }
    end

    protected

    def make_histogram(url)
      puts url
      file = save_to_tempfile(url, "instagram_media_#{media_item.id}")
      Incollage::HistogramMaker.new(file.path).make
    end

    def make_file_path
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
