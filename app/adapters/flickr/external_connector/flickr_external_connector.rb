module FlickrAdapter
  class ExternalConnector < OAuthAdapter::ExternalAccountConnector::Base

    def connect(controller, user_id)
      url = redirect_url(controller, user_id)
      token = request_token(url)
      remember_secret(controller, token['oauth_token'], token['oauth_token_secret'])
      controller.redirect_to auth_url(token['oauth_token'])
    end

    def callback(controller, _user_id)
      oauth_token,  verifier = controller.params[:oauth_token], controller.params[:oauth_verifier]
      oauth_secret = fetch_secret(controller, oauth_token)
      response = fetch_response(oauth_token, oauth_secret, verifier)
      controller.redirect_to controller.root_path
      response
    end

    protected

    def remember_secret(controller, token, secret)
      controller.session[token] = secret
    end

    def fetch_secret(controller, token)
      controller.session[token]
    end

    def result(response)
      %w{ user_nsid fullname username }.each do |key|
        response[key] = CGI.unescape(response[key])
      end
      {
          external_user_id: response['user_nsid'],
          meta_info: response.merge({user: { username: response['username'] }} )
      }
    end

    def request_token(url)
      client.get_request_token(oauth_callback: url)
    end

    def auth_url(oauth_token)
      client.get_authorize_url(oauth_token, perms: 'read')
    end

    def fetch_response(oauth_token, oauth_secret, verifier)
      result client.get_access_token(oauth_token, oauth_secret, verifier)
    end

    def client
      @client ||= Client.get
    end
  end
end
