module Incollage
  class ExternalAccountsHolder

    def add(attrs)
      account = ExternalAccount.new(attrs)
      account.check_validity!
      add_account(account)
    end

    def get(identifier)
      return get_account_by_id(identifier) if identifier.is_a?(Numeric)
      return get_account_by_name(identifier) if identifier.is_a?(Symbol)
      nil
    end

    def get_account_by_id(id)
      accounts[id]
    end

    def get_account_by_name(name)
      added_accounts.find do |acc|
        acc.name == name
      end
    end

    def added_accounts
      accounts.values
    end

    protected

    def add_account(account)
      raise ArgumentError.new("Account ID #{account.id} is already occupied!") if accounts[account.id]
      accounts[account.id] = account
    end

    def accounts
      @accounts ||= {}
    end

  end
end
