module FacebookAdapter
  class Authentication
    attr_reader :redirect_uri

    def initialize(redirect_uri)
      @redirect_uri = redirect_uri
    end

    def authorize_url
      oauth.url_for_oauth_code + permissions_scope
    end

    def metadata(code)
      token = oauth.get_access_token(code)
      connection = client(token)
      user = connection.get_object('me')
      { access_token: token, user: user }
    end

    def client(token)
      self.class.client(token)
    end

    def self.client(token)
      Koala::Facebook::API.new(token, FacebookConfig.app_secret)
    end

    protected

    def oauth
      Koala::Facebook::OAuth.new(FacebookConfig.app_id, FacebookConfig.app_secret, redirect_uri)
    end

    def permissions_scope
      permissions = [
          :public_profile,
          :user_events,
          :user_photos,
          :user_posts,
          :'user_actions.news',
      ]
      '&scope='+permissions*?,
    end

  end
end

