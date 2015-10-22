module Incollage
  module ExternalAccountConnector

    class Base
      attr_reader :external_account_id

      def initialize(external_account_id)
        @external_account_id = external_account_id
      end

      def connect(user_id, context)
        raise NotImplemented
      end

      def callback(user_id, context)
        raise NotImplemented
      end

      # method must be called when obtained @external_user_id and @meta_info
      # in 'connect' or 'callback' methods
      def on_connected(user_id, external_user_id, meta_info)
        attrs = {
            external_account_id: self.external_account_id,
            user_id: user_id,
            external_user_id: external_user_id,
            external_meta_info: meta_info
        }
        Incollage::LinkExternalAccount.new(attrs).execute
      end

    end

  end
end
