RSpec.configure do |config|
  require 'active_support/all'
  require 'active_model'
  require 'pry'

  def app_root
    require 'pathname'
    Pathname.new(ENV['INCOLLAGE_ROOT'])
  end

  require app_root.join('app/core/core')
  Incollage.load_modules(app_root.join('app/core'))
  Incollage.load_modules(app_root.join('app/adapters/imagemagick'), [])
  Incollage.load_modules(app_root.join('spec/support'), [])

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)

    Incollage::Service.register(:downloader, TestSupport::FakeHttpDownloader.new)
    Incollage::Service.register(:collage_filestorage, LocalCollageFilestorage .new(app_root.join('/tmp')))

    Incollage::Service.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    Incollage::Service.register(:collage_maker_factory, TestSupport::FakeCollageMaker)
    Incollage::Service.register(:histogram_maker_factory, TestSupport::FakeHistogramMaker)

    Incollage::Holder.register(:clippings_collections, collections_holder)
    Incollage::Holder.register(:external_accounts, external_accounts_holder)
  end

  config.before :each do |example|
    register_repos
  end

  # Methods

  def fixture_file(path)
    app_root.join('spec', 'fixtures', path)
  end

  def picture_file(picture)
    fixture_file([ 'pictures', picture ]*?/)
  end

  def collections_holder
    holder = Incollage::ClippingsCollectionsHolder.new
    holder.add(
        id: 1,
        name: :test_collection,
        label: 'Test Collection',
        source: Incollage::ClippingsSource::InMemory::Source.new
    )
    holder
  end

  def external_accounts_holder
    holder = Incollage::ExternalAccountsHolder.new
    holder.add(
        id: 1,
        name: :test_account,
        label: 'External Account',
        collections: [ Incollage::Holder.for_clippings_collections.get(:test_collection) ]
    )
    holder
  end

end
