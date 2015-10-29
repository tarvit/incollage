module Incollage
  class GetUserAccountStatistics

    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      accounts_data
    end

    protected

    def accounts_data
      accounts_data = Holder.for_external_accounts.added_accounts.map do |external_account|
        linked_account_id = linked_account(external_account).try(:id)
        {
            id: external_account.id,
            name: external_account.name,
            label: external_account.label,
            linked: (!!linked_account_id),
            linked_account_id: linked_account_id,
            collections: collections_data(external_account, linked_account_id)
        }

      end
      { accounts: accounts_data }
    end

    def linked_account(external_account)
      Repository.for_linked_account.find(user_id: @user_id, external_account_id: external_account.id)
    end

    def collections_data(external_account, linked_account_id)
      external_account.collections.map do |collection|
        {
            id: collection.id,
            name: collection.name,
            label: collection.label,
            clippings_count: clippings_count(collection, linked_account_id)
        }
      end
    end

    def clippings_count(external_collection, linked_account_id)
      return 0 unless linked_account_id
      Repository.for_clipping.count(
          user_id: @user_id,
          collection_id: external_collection.id,
          linked_account_id: linked_account_id
      )
    end
  end
end
