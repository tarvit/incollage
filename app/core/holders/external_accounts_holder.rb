module Incollage
  class ExternalAccountsHolder  < ObjectsHolder::NamedEntityBase

    def added_accounts
      added
    end

    protected

    def entity_klass
      ExternalAccount
    end
  end
end
