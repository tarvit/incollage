require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module IncollageApp

  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end

  def self.load_all_modules
    # load Core modules
    require Rails.root.join('app/core/core')
    Incollage.load_modules(Rails.root.join('app/core'))

    # load application adapters
    Incollage.load_modules(Rails.root.join('app/adapters'), [])

    set_adapters
  end

  def self.set_adapters
    Incollage::Repository.register(:user, UserActiveRecord::Repository.new)
    Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)
    Incollage::Gateway.register(:downloader, SimpleHttpDownloader.new)
    Incollage::Gateway.register(:color_matcher, Imagemagick::PaletteColorMatcher.new)
    Incollage::Gateway.register(:histogram_maker_factory, Imagemagick::HistogramMaker)
    Incollage::Gateway.register(:collage_maker_factory, Imagemagick::CollageMaker)
  end

end

IncollageApp.load_all_modules
