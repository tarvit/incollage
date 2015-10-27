class Api::V1::StatsController < ApiController

  def show
    stats = Incollage::GetUserAccountsStatistics.new(current_user.id).execute
    success StatsPresenter.new(stats)._custom_hash
  end

  class StatsPresenter < TarvitHelpers::HashPresenter::Custom

    def _init_rules
      _rules.when([ :accounts, :connect ]) do |value, object|
        {
            url: Rails.application.routes.url_helpers.api_v1_external_accounts_connect_path(external_account_id: object.id),
            label: (object.linked ? 'Reconnect' : 'Connect'),
            tooltip: (object.linked ? 'Your external session may be expired.' : 'You will be able to sync your collections then.'),
        }
      end

      _rules.when([ :accounts, :collections, :sync ]) do |value, object|
        {
            #url:
        }
      end
    end

  end
end
