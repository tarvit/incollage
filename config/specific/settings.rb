class SpecificSettings
  attr_reader :collections_holder, :accounts_holder, :access_codes_holder,
              :standard_colors_holder

  def initialize
    init_collections_holder
    init_accounts_holder
    init_access_codes_holder
    init_standard_colors_holder
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

  def init_access_codes_holder
    @access_codes_holder = Incollage::AccessCodesHolder.new
    @access_codes_holder.add ENV['ACCESS_CODE']
  end

  def init_standard_colors_holder
    @standard_colors_holder = Incollage::StandardColorsHolder.new
    [
        { id: 1, name: :White,	hex_value: 'FFFFFF' },
        { id: 2, name: :Yellow,hex_value:'FFFF00' },
        { id: 3, name: :Pink,	hex_value: 'ffc0cb' },
        { id: 4, name: :Red,	hex_value: 'FF0000' },
        { id: 5, name: :Silver, hex_value: 'C0C0C0' },
        { id: 6, name: :Chocolate,	hex_value: 'd2691e' },
        { id: 7, name: :Indigo, hex_value:'4b0082' },
        { id: 8, name: :Aqua, hex_value: '00FFFF' },
        { id: 9, name: :Lime, hex_value: '00FF00' },
        { id: 10, name: :Green,	hex_value: '008000' },
        { id: 11, name: :DogerBlue, hex_value: '1e90ff' },
        { id: 12, name: :Black, hex_value: '000000' },
    ].each do |color_attrs|
      @standard_colors_holder.add color_attrs
    end
  end
end
