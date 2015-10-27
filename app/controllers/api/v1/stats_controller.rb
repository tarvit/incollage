class Api::V1::StatsController < ApiController

  def show
    stats = Incollage::GetUserAccountsStatistics.new(current_user.id).execute
    success StatsPresenter.new(stats)._custom_hash
  end

  class StatsPresenter < TarvitHelpers::HashPresenter::Custom

    def _init_rules
      _rules.when([ :accounts, :connect ]) do |value, object|
        {
            url: _route.api_v1_external_accounts_connect_path(external_account_id: object.id),
            label: (object.linked ? 'Reconnect' : 'Connect'),
            tooltip: (object.linked ? 'Your external session may be expired.' : 'You will be able to sync your collections then.'),
        }
      end

      _rules.when([ :accounts, :collections, :sync ]) do |value, object|
        if object._parent.linked
          {
              url:  _route.api_v1_external_collections_sync_path(
                  external_account_id: object._parent.id,
                  linked_account_id: object._parent.linked_account_id,
                  external_collection_id: object.id
              )
          }
        else
          {  }
        end
      end
    end

    def _route
      Rails.application.routes.url_helpers
    end

  end
end
