class ApplicationController < ActionController::Base
  require Rails.root.join 'app/controllers/application/session'
  include ApplicationControllerSession

  protect_from_forgery with: :exception
  before_filter :reload_core, if: ->{ Rails.env.development? }
  include Incollage

  def reload_core
    IncollageApp.load_all_modules
  end

end
