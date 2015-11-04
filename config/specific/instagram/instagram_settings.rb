class SpecificSettings
  class InstagramSettings

    class << self
      def account_opts(collections_holder)
        {
            id: 1,
            name: :instagram_account,
            label: 'Instagram Account',
            connector: InstagramAdapter::ExternalConnector.new(1),
            collections: [ :instagram_feed, :instagram_posts ].map{|id| collections_holder.get(id)}
        }
      end

      def feed_collection_opts
        {
            id: 1,
            name: :instagram_feed,
            label: 'My Instagram Feed',
            source: InstagramAdapter::ClippingsSource::ReceivedMediaSource.new
        }
      end

      def posts_collection_opts
        {
            id: 2,
            name: :instagram_posts,
            label: 'My Instagram Posts',
            source: InstagramAdapter::ClippingsSource::PostedMediaSource.new
        }
      end
    end
  end
end
