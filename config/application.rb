require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Incollage

  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end

end

# load Core services
require Rails.root.join( %w{ app core core } * ?/ )
Incollage::Core.load_modules(Rails.root)