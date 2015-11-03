module FacebookAdapter
  class ExternalConnector < OAuthAdapter::ExternalAccountConnector::Base

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
      Authentication.new(url).metadata(code)
    end
  end
end
