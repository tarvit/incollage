module InstagramAdapter

  class ExternalConnector < Incollage::ExternalAccountConnector::Base

    def connect(controller, user_id)
      url = redirect_url(controller, user_id)
      controller.redirect_to Authentication.new(url).authorize_url
    end

    def callback(controller, user_id)
      url = redirect_url(controller, user_id)
      response = fetch_response(url, controller.params[:code])
      meta_info = { access_token: response.access_token, user: response.user }
      on_connected(user_id, response.user.id, meta_info )
      controller.redirect_to controller.root_path
    end

    protected

    def redirect_url(controller, user_id)
      controller.api_v1_external_accounts_callback_url(
          trailing_slash: true,
          external_account_id: self.external_account_id,
          user_id: user_id
      )
    end

    def fetch_response(url, code)
      Authentication.new(url).get_response(code)
    end
  end
end
