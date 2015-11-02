module Incollage
  module LinkExternalAccount

    class Base
      attr_reader :user_id, :external_account_id, :context, :connector

      def initialize(user_id, external_account_id, context)
        @user_id, @external_account_id, @context = user_id, external_account_id, context
        @connector = Holder.for_external_accounts.get(external_account_id).connector
      end
    end

    class Connect < Base
      def execute
        connector.connect(context, user_id)
      end
    end

    class Callback < Base
      def execute
        response = connector.callback(context, user_id)
        CreateOrUpdateExternalAccount.new(attributes(response)).execute
      end

      protected

      def attributes(response)
        {
            user_id: user_id,
            external_account_id: external_account_id,
            external_meta_info: response[:meta_info],
            external_user_id: response[:external_user_id],
        }
      end

    end
  end
end
