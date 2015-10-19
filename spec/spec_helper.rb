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
    holder = Incollage::ClippingsCollectionsHolder.new
    holder.add(1, 'test_collection', Incollage::ClippingsSource::InMemory::Source.new)
    holder
  end

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)

    Incollage::Service.register(:downloader, TestSupport::FakeHttpDownloader.new)
    Incollage::Service.register(:collage_filestorage, LocalCollageFilestorage .new(app_root.join('/tmp')))

    Incollage::Service.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    Incollage::Service.register(:collage_maker_factory, TestSupport::FakeCollageMaker)
    Incollage::Service.register(:histogram_maker_factory, TestSupport::FakeHistogramMaker)

    Incollage::Service.register(:clippings_collection_holder, collection_holder)
  end

  config.before :each do |example|
    register_repos
  end

end
