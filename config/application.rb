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

  def self.collections_holder
    holder = Incollage::ClippingsCollectionsHolder.new
    collections = [
        [ 1, 'My Instagram Feed', InstagramClippingsSource::ReceivedMediaSource.new ],
        [ 2, 'My Instagram Posts', InstagramClippingsSource::PostedMediaSource.new ],
    ]
    collections.each do |collection|
      holder.add(*collection)
    end
    holder
  end

  def external_accounts_holder
    holder = Incollage::ExternalAccountsHolder.new
    holder.add(1, 'Instagram Account', [ 1, 2 ].map{|id| Incollage::Holder.for_clippings_collections.get(id) })
    holder
  end

  def self.set_adapters
    Incollage::Repository.register(:user, UserActiveRecord::Repository.new)
    Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)

    Incollage::Service.register(:downloader, SimpleHttpDownloader.new)
    Incollage::Service.register(:collage_filestorage, LocalCollageFilestorage .new(Rails.root.join('public/fs')))

    Incollage::Service.register(:color_matcher, Imagemagick::PaletteColorMatcher.new)
    Incollage::Service.register(:histogram_maker_factory, Imagemagick::HistogramMaker)
    Incollage::Service.register(:collage_maker_factory, Imagemagick::CollageMaker)

    Incollage::Holder.register(:clippings_collections, collections_holder)
    Incollage::Holder.register(:external_accounts, external_accounts_holder)
  end

end

IncollageApp.load_all_modules
