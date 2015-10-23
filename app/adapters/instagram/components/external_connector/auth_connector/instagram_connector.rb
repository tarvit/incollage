module InstagramAdapter
  class Authentication
    attr_reader :redirect_uri

    def initialize(redirect_uri)
      @redirect_uri = redirect_uri
    end

    def authorize_url
      Instagram.authorize_url(:redirect_uri => redirect_uri)
    end

    def get_response(code)
      Instagram.get_access_token(code, :redirect_uri => redirect_uri)
    end
  end

end
