module InstagramAdapter
  class ExternalConnector < OAuthAdapter::ExternalAccountConnector::Base

    def callback(controller, user_id)
      url = redirect_url(controller, user_id)
      response = fetch_response(url, controller.params[:code])
      controller.redirect_to controller.root_path
      result(response)
    end

    protected

    def authorize_url(url)
      Authentication.new(url).authorize_url
    end

    def result(response)
      {
          external_user_id: response.user.id,
          meta_info: { access_token: response.access_token, user: response.user }
      }
    end

    def fetch_response(url, code)
      Authentication.new(url).get_response(code)
    end
  end
end
