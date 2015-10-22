class SpecificSettings
  attr_reader :collections_holder, :accounts_holder

  def initialize
    init_collections_holder
    init_accounts_holder
  end

  def init_collections_holder
    @collections_holder = Incollage::ExternalClippingsCollectionsHolder.new
    collections = [
        { id: 1, name: :instagram_feed, label: 'My Instagram Feed', source: InstagramClippingsSource::ReceivedMediaSource.new },
        { id: 2, name: :instagram_posts, label: 'My Instagram Posts', source: InstagramClippingsSource::PostedMediaSource.new },
    ]
    collections.each do |collection|
      @collections_holder.add(collection)
    end
  end

  def init_accounts_holder
    @accounts_holder = Incollage::ExternalAccountsHolder.new
    @accounts_holder.add(
        id: 1,
        name: :instagram_account,
        label: 'Instagram Account',
        connector: TestSupport::FakeAccountConnector.new(1),
        collections: [ :instagram_feed, :instagram_posts ].map{|id| @collections_holder.get(id)}
    )
    @accounts_holder
  end

end