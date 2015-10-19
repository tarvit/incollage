module Incollage
  class ExternalAccountsHolder

    def add(id, name, collections)
      collection = ExternalAccount.new(id, name, collections)
      add_account(collection)
    end

    def get_account(id)
      accounts[id]
    end

    alias_method :get, :get_account


    def added_accounts
      accounts.values
    end

    protected

    def add_account(account)
      accounts[account.id] = account
    end

    def accounts
      @accounts ||= {}
    end

  end
end
