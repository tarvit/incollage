module Incollage
  class RegisterUser

    def initialize(user_data)
      @user_data = user_data
    end

    def execute
      entity = build_entity
      raise UsernameTakenError if Repository.for_user.username_occupied?(entity.username)
      Repository.for_user.save(entity)
    end

    class UsernameTakenError < StandardError; end

    private

    def build_entity
      User.new(@user_data)
    end

  end
end
