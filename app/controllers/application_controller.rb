class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :reload_core, if: ->{ Rails.env.development? }
  include Incollage

  def authorized?
    !!session[:access_token]
  end

  def authorize_access(access_token)
    session[:access_token] = access_token
  end

  def restrict_access
    session[:access_token] = nil
  end

  def access_token
    session[:access_token]
  end

  def check_authorized!
    redirect_to auth_login_path unless authorized?
  end

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
