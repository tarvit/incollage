RSpec.configure do |config|
  require 'active_support/all'
  require 'active_model'
  require 'pry'
  require 'tarvit-helpers'

  extend TarvitHelpers::RecursiveLoader::Context

  def app_root
    require 'pathname'
    Pathname.new(ENV['INCOLLAGE_ROOT'])
  end

  load_modules(app_root.join('app/core'), %w{ base entities interactors adapters components holders })
  load_modules(app_root.join('app/adapters/imagemagick'), [])
  load_modules(app_root.join('app/adapters/actioncontroller'), [])
  load_modules(app_root.join('spec/support'), [])

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)
    Incollage::Repository.register(:linked_account, Incollage::Repository::LinkedAccountInMemoryRepository.new)

    Incollage::Service.register(:downloader, TestSupport::FakeHttpDownloader.new)
    Incollage::Service.register(:uploader, TestSupport::FakeUploader.new)
    Incollage::Service.register(:local_filestorage, LocalFileStorage.new(app_root.join('tmp')))

    Incollage::Service.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    Incollage::Service.register(:collage_maker, TestSupport::FakeCollageMaker.new)
    Incollage::Service.register(:histogram_maker, TestSupport::FakeHistogramMaker.new)

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
    holder = Incollage::ExternalClippingsCollectionsHolder.new
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
        connector: TestSupport::FakeAccountConnector.new(1),
        collections: [ Incollage::Holder.for_clippings_collections.get(:test_collection) ]
    )
    holder
  end

end
