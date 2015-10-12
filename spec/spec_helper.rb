# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  def app_root
    Rails.root
  end

  def fixture_file(path)
    Rails.root.join('spec', 'fixtures', path)
  end

  def picture_file(picture)
    fixture_file([ 'pictures', picture ]*?/)
  end

  def register_repos
    Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)
    #Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)

    Incollage::Gateway.register(:color_matcher, Incollage::PaletteColorMatcher.new)
    Incollage::Gateway.register(:collage_maker_factory, Incollage::CollageMaker)
  end

  config.before :each do |example|
    register_repos
  end

  require app_root.join('spec/core/support/factories/clipping_factory')

end
