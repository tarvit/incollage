require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module IncollageApp

  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.angular_templates.module_name    = 'templates'
    config.angular_templates.ignore_prefix  = %w(templates/)
  end

  extend TarvitHelpers::RecursiveLoader::Context

  def self.load_all_modules
    load_method = :require

    # load Core modules
    load_modules(Rails.root.join('app/core'), %w{ base entities interactors adapters components holders }, load_method)

    # load application adapters
    load_modules(Rails.root.join('app/adapters'), [], load_method)

    # load application specific settings
    load_modules(Rails.root.join('config/specific'), [], load_method)

    set_adapters
  end

  def self.set_adapters
    Incollage::Repository.register(:user, UserActiveRecord::Repository.new)
    Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)
    Incollage::Repository.register(:linked_account, LinkedAccountActiveRecord::Repository.new)

    Incollage::Service.register(:downloader, SimpleHttpDownloader.new)
    Incollage::Service.register(:collage_filestorage, LocalCollageFilestorage .new(Rails.root.join('public/fs')))

    Incollage::Service.register(:color_matcher, Imagemagick::PaletteColorMatcher.new)
    Incollage::Service.register(:histogram_maker_factory, Imagemagick::HistogramMaker)
    Incollage::Service.register(:collage_maker_factory, Imagemagick::CollageMaker)

    @settings = SpecificSettings.new
    Incollage::Holder.register(:clippings_collections, @settings.collections_holder)
    Incollage::Holder.register(:external_accounts, @settings.accounts_holder)
  end

end

IncollageApp.load_all_modules
