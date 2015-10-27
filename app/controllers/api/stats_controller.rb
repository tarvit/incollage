class Api::StatsController < ApiController

  def show
    stats = Incollage::GetUserAccountsStatistics.new(current_user.id).execute
    success StatsPresenter.new(stats)._custom_hash
  end

  class StatsPresenter < TarvitHelpers::HashPresenter::Custom

    def _init_rules
      _rules.when([ :accounts, :connect_url ]) do |value, object|
        Rails.application.routes.url_helpers.external_accounts_connect_path(external_account_id: object.id)
      end
    end
  end
end
