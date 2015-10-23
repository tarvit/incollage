module InstagramAdapter

  class ExternalConnector < Incollage::ExternalAccountConnector::Base

    def connect(controller, user_id)
      url = redirect_url(controller, user_id)
      controller.redirect_to Authentication.new(url).authorize_url
    end

    def callback(controller, user_id)
      url = redirect_url(controller, user_id)
      response = Authentication.new(url).get_response(controller.params[:code])
      on_connected(user_id, response.user.id, access_token: response.access_token )
      controller.redirect_to controller.collage_builder_path
    end

    protected

    def redirect_url(controller, user_id)
      controller.external_accounts_callback_url(
          trailing_slash: true,
          external_account_id: self.external_account_id,
          user_id: user_id
      )
    end
  end
end
