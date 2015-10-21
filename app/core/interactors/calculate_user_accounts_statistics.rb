module Incollage
  class CalculateUserAccountsStatistics

    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      populate_external_accounts
    end

    protected

    def populate_external_accounts
      accounts_data = Holder.for_external_accounts.added_accounts.map do |ext_acc|
        linked_acc = linked_account(ext_acc)
        {
            external_account_id: ext_acc.id,
            external_account_name: ext_acc.name,
            external_account_label: ext_acc.label,
            linked: (!!linked_acc),
            linked_account_id: linked_acc.try(:id),
        }

      end
      { external_accounts: accounts_data }
    end

    def linked_account(exernal_account)
      Repository.for_linked_account.find(user_id: @user_id, external_account_id: exernal_account.id)
    end

    def user
      @user ||= Repository.for_user.find(id: @user_id)
    end

  end
end
