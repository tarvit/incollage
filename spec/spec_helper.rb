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

  def fixture_file(path)
    app_root.join('spec', 'fixtures', path)
  end

  def picture_file(picture)
    fixture_file([ 'pictures', picture ]*?/)
  end

  def collection_holder
    holder = Incollage::ClippingsCollectionHolder.new
    collection = Incollage::ClippingsCollection.new(1, :instagram_received, Incollage::ClippingsSource::InMemory::Source.new)
    holder.add(collection)
    holder
  end

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)

    Incollage::Gateway.register(:downloader, TestSupport::FakeHttpDownloader.new)
    Incollage::Gateway.register(:collage_filestorage, LocalCollageFilestorage .new(app_root.join('/tmp')))

    Incollage::Gateway.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    Incollage::Gateway.register(:collage_maker_factory, TestSupport::FakeCollageMaker)
    Incollage::Gateway.register(:histogram_maker_factory, TestSupport::FakeHistogramMaker)

    Incollage::Service.register(:clippings_collection_holder, collection_holder)
  end

  config.before :each do |example|
    register_repos
  end

end
