class AccountStatsPresenter < BasePresenter

  def _add_rules(rules)
    rules.when([ :accounts, :connect ]) do |value, object|
      {
          url: _route.api_v1_external_accounts_connect_path(external_account_id: object.id),
          label: (object.linked ? 'Reconnect' : 'Connect'),
          tooltip: (object.linked ? 'Your external session may be expired.' : 'You will be able to sync your collections then.'),
      }
    end

    rules.when([ :accounts, :collections, :sync ]) do |value, object|
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
end
