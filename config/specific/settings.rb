class SpecificSettings
  attr_reader :collections_holder, :accounts_holder

  def initialize
    init_collections_holder
    init_accounts_holder
  end

  def init_collections_holder
    @collections_holder = Incollage::ClippingsCollectionsHolder.new
    collections = [
        [ 1, 'My Instagram Feed', InstagramClippingsSource::ReceivedMediaSource.new ],
        [ 2, 'My Instagram Posts', InstagramClippingsSource::PostedMediaSource.new ],
    ]
    collections.each do |collection|
      @collections_holder.add(*collection)
    end
  end

  def init_accounts_holder
    @accounts_holder = Incollage::ExternalAccountsHolder.new
    @accounts_holder.add(1, 'Instagram Account', [ 1, 2 ].map{|id| @collections_holder.get(id) })
    @accounts_holder
  end

end