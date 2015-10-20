module Incollage
  class LinkExternalAccount

    def initialize(user_id, external_account_id)
      @user_id, @external_account_id = user_id, external_account_id
    end

    def execute
      raise NotImplementedError
    end

    protected

    def user
      Repository.for_user.find(id: @user_id)
    end

    def external_account
      Holder.for_external_accounts.get(@external_account_id)
    end

  end
end
