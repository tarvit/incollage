module OAuthAdapter
  module ExternalAccountConnector
    class Base < Incollage::ExternalAccountConnector::Base

      def connect(controller, user_id)
        url = redirect_url(controller, user_id)
        controller.redirect_to authorize_url(url)
      end

      def callback(controller, user_id)
        url = redirect_url(controller, user_id)
        response = fetch_response(url, controller.params[:code])
        controller.redirect_to controller.root_path
        response
      end

      protected

      def authorize_url(url)
        raise NotImplemented
      end

      def fetch_response(url, code)
        raise NotImplemented
      end

      def redirect_url(controller, user_id)
        controller.api_v1_external_accounts_callback_url(
            trailing_slash: true,
            external_account_id: self.external_account_id,
            user_id: user_id
        )
      end
    end
  end
end
