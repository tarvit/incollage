module Incollage
  class AuthenticateUser

    def initialize(session, user_data)
      @session = session
      @username, @password = user_data[:username], user_data[:password]
    end

    def execute
      user = Repository.for_user.find(username: @username)
      raise AuthenticationFailedError unless user

      result = user.authenticate(@password)
      raise AuthenticationFailedError unless result

      @session.authenticate(user.id)
    end

    class AuthenticationFailedError < StandardError; end

    private

    def build_entity
      User.new(@user_data)
    end

  end
end
