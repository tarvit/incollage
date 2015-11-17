RSpec.configure do |config|
  # Core Dependencies
  require 'active_support/all'
  require 'active_model'
  require 'tarvit-helpers'
  require 'virtus'

  # Test Setup
  require 'pry'
  require_relative './support/config/dependencies'
  extend TarvitHelpers::RecursiveLoader::Context

  # CodeClimate
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start

  def app_root
    require 'pathname'
    Pathname.new(ENV['INCOLLAGE_ROOT'])
  end

  require app_root.join('app/core/incollage')
  Incollage.load

  load_modules(app_root.join('app/adapters/imagemagick'), [])
  load_modules(app_root.join('spec/support'), [])


  config.before :each do |example|
    example.extend TestSupport::Dependencies
    example.clear_gateways
  end

  # Methods

  def fixture_file(path)
    app_root.join('spec', 'fixtures', path)
  end

  def picture_file(picture)
    fixture_file([ 'pictures', picture ]*?/)
  end

end
