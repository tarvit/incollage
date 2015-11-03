module FacebookAdapter
  class Authentication
    attr_reader :redirect_uri

    def initialize(redirect_uri)
      @redirect_uri = redirect_uri
    end

    def authorize_url
      oauth.url_for_oauth_code
    end

    def metadata(code)
      token = oauth.get_access_token(code)
      connection = client(token)
      user = connection.get_object('me')
      { access_token: token, user: user }
    end

    def client(token)
      Koala::Facebook::API.new(token)
    end

    protected

    def oauth
      Koala::Facebook::OAuth.new(FacebookConfig.app_id, FacebookConfig.app_secret, redirect_uri)
    end

  end
end

