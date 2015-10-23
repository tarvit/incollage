module Incollage
  class GetUserInfo

    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      user = Repository.for_user.find(id: @user_id)
      present(user) if user
    end

    protected

    def present(user)
      {
          id: user.id,
          full_name: user.full_name,
          username: user.username,
      }
    end

  end
end
