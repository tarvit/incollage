class SpecificSettings
  require_relative '../specific/instagram/instagram_settings'
  attr_reader :collections_holder, :accounts_holder

  def initialize
    init_collections_holder
    init_accounts_holder
  end

  def init_collections_holder
    @collections_holder = Incollage::ExternalClippingsCollectionsHolder.new
    collections = [
        InstagramSettings.feed_collection_opts,
        InstagramSettings.posts_collection_opts,
        FlickrSettings.feed_collection_opts,
    ]
    collections.each do |collection|
      @collections_holder.add(collection)
    end
  end

  def init_accounts_holder
    @accounts_holder = Incollage::ExternalAccountsHolder.new
    @accounts_holder.add(InstagramSettings.account_opts(collections_holder))
    @accounts_holder.add(FlickrSettings.account_opts(collections_holder))
  end

end
