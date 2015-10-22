module Incollage
  module ExternalAccountConnector

    class Base
      attr_reader :external_account_id

      def initialize(external_account_id)
        @external_account_id = external_account_id
      end

    end

  end
end
