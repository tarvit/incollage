class ApplicationController < ActionController::Base
  require Rails.root.join 'app/controllers/application/session'
  include ApplicationControllerSession

  protect_from_forgery with: :exception
  before_filter :reload_core, if: ->{ Rails.env.development? }
  include Incollage

  def reload_core
    IncollageApp.load_all_modules
  end

  protected

  def init_current_stats
    stats = Incollage::GetUserAccountsStatistics.new(current_user.id).execute
    @current_stats = TarvitHelpers::HashPresenter.present(stats)
  end

end
