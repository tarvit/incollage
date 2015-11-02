module Incollage
  module ExternalAccountConnector

    class Base
      attr_reader :external_account_id

      def initialize(external_account_id)
        @external_account_id = external_account_id
      end

      def connect(context, user_id)
        raise NotImplemented
      end

      def callback(context, user_id)
        raise NotImplemented
      end

    end
  end
end
