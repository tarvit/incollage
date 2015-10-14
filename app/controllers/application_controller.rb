class ApplicationController < ActionController::Base
  require Rails.root.join 'app/controllers/application/session'
  require Rails.root.join 'app/controllers/application/current_user'

  include ApplicationControllerSession
  include ApplicationControllerCurrentUser

  protect_from_forgery with: :exception
  before_filter :reload_core, if: ->{ Rails.env.development? }
  include Incollage

  def reload_core
    IncollageApp.load_all_modules
  end

  protected

  def current_collection_id
    (cookies[:current_collection_id] || Incollage::Service.for_clippings_source_factory.first_collection).to_i
  end

  def current_user_collection
    Incollage::ClippingsCollection.new(current_user.id, current_collection_id)
  end

end
