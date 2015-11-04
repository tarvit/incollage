module FacebookAdapter
  class ExternalConnector < OAuthAdapter::ExternalAccountConnector::Base

    protected

    def authorize_url(url)
      Authentication.new(url).authorize_url
    end

    def result(response)
      {
          external_user_id: response[:user]['id'],
          meta_info: response
      }
    end

    def fetch_response(url, code)
      result Authentication.new(url).metadata(code)
    end
  end
end
