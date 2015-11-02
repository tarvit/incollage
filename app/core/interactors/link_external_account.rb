module Incollage
  module LinkExternalAccount

    class Base
      attr_reader :user_id, :external_account_id, :connector

      def initialize(user_id, external_account_id)
        @user_id, @external_account_id = user_id, external_account_id
        @connector = Holder.for_external_accounts.get(external_account_id).connector
      end
    end

    class Connect < Base
      def execute(context)
        connector.connect(context, user_id)
      end
    end

    class Callback < Base
      def execute(context)
        connector.callback(context, user_id)
      end
    end

  end
end
