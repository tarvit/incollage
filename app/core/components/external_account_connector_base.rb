module Incollage
  module ExternalAccountConnector

    class Base
      attr_reader :external_account_id

      def initialize(external_account_id)
        @external_account_id = external_account_id
      end

      def connect(_context, _user_id)
        raise NotImplemented
      end

      def callback(_context, _user_id)
        raise NotImplemented
      end

    end
  end
end
