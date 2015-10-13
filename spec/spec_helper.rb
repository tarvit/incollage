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

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)
    #Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)

    Incollage::Gateway.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    Incollage::Gateway.register(:collage_maker_factory, TestSupport::FakeCollageMaker)
  end

  config.before :each do |example|
    register_repos
  end

end
