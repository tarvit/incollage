class SpecificSettings
  attr_reader :collections_holder, :accounts_holder

  def initialize
    init_collections_holder
    init_accounts_holder
  end

  def init_collections_holder
    @collections_holder = Incollage::ExternalClippingsCollectionsHolder.new
    collections = [ instagram_feed_collection_opts, instagram_posts_collection_opts ]
    collections.each do |collection|
      @collections_holder.add(collection)
    end
  end

  def init_accounts_holder
    @accounts_holder = Incollage::ExternalAccountsHolder.new
    @accounts_holder.add(instagram_account_opts)
  end

  protected

  def instagram_account_opts
    {
        id: 1,
        name: :instagram_account,
        label: 'Instagram Account',
        connector: InstagramAdapter::ExternalConnector.new(1),
        collections: [ :instagram_feed, :instagram_posts ].map{|id| @collections_holder.get(id)}
    }
  end

  def instagram_feed_collection_opts
    {
        id: 1,
        name: :instagram_feed,
        label: 'My Instagram Feed',
        source: InstagramAdapter::ClippingsSource::ReceivedMediaSource.new
    }
  end

  def instagram_posts_collection_opts
    {
        id: 2,
        name: :instagram_posts,
        label: 'My Instagram Posts',
        source: InstagramAdapter::ClippingsSource::PostedMediaSource.new
    }
  end
end
