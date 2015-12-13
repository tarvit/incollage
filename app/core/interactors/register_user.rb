module Incollage
  class RegisterUser

    def initialize(user_data, access_code)
      @user_data = user_data
      @access_code = access_code
    end

    def execute
      entity = build_entity

      raise UsernameTakenError if Repository.for_user.username_occupied?(entity.username)
      raise AccessCodeInvalidError unless Holder.for_access_codes.has?(@access_code)

      Repository.for_user.save(entity)
    end

    class UsernameTakenError < StandardError; end
    class AccessCodeInvalidError < StandardError; end

    private

    def build_entity
      User.new(@user_data)
    end

  end
end
