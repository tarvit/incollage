class ApplicationController < ActionController::Base
  require Rails.root.join 'app/controllers/application/session'
  require Rails.root.join 'app/controllers/application/current_user'
  include ApplicationControllerSession
  include ApplicationControllerCurrentUser

  protect_from_forgery with: :exception
  before_filter :reload_core, if: ->{ Rails.env.development? }
  include Incollage

  def self.reload_core
    Incollage.load_modules(Rails.root.join('app/core'))
    set_adapters
  end

  def reload_core
    self.class.reload_core
  end

  def self.set_adapters
    Incollage::Repository.register(:user, UserActiveRecord::Repository.new)
    Incollage::Repository.register(:clipping, ClippingActiveRecord::Repository.new)
  end

  reload_core
  set_adapters
end
