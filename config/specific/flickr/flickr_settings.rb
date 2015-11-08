class SpecificSettings
  class FlickrSettings

    class << self
      def account_opts(collections_holder)
        {
            id: 2,
            name: :flickr_account,
            label: 'Flickr Account',
            connector: FlickrAdapter::ExternalConnector.new(2),
            collections: [ :flickr_feed ].map{|id| collections_holder.get(id)}
        }
      end

      def feed_collection_opts
        {
            id: 3,
            name: :flickr_feed,
            label: 'My Flickr Feed',
            source: FlickrAdapter::ClippingsSource::GlobalClippingsSource.new
        }
      end
    end
  end
end
