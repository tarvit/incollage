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
        { name: :White,	hex_value: 'FFFFFF' },
        { name: :Yellow,hex_value:'FFFF00' },
        { name: :Fuchsia,	hex_value: 'FF00FF' },
        { name: :Red,	hex_value: 'FF0000' },
        { name: :Silver, hex_value: 'C0C0C0' },
        { name: :Olive,	hex_value: '808000' },
        { name: :Purple, hex_value:'800080' },
        { name: :Maroon, hex_value:'800000' },
        { name: :Aqua, hex_value: '00FFFF' },
        { name: :Lime, hex_value: '00FF00' },
        { name: :Green,	hex_value: '008000' },
        { name: :Blue, hex_value: '0000FF' },
        { name: :Black, hex_value: '000000' },
    ].each do |color_attrs|
      @standard_colors_holder.add color_attrs
    end
  end
end
