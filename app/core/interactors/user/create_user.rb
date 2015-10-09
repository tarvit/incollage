module Incollage
  class FindOrCreateUser

    def initialize(user_data)
      @user_data = user_data
    end

    def execute
      entity = build_entity
      Repository.for_user.find(@user_data) || Repository.for_user.save(entity)
    end

    private

    def build_entity
      User.new(@user_data)
    end

  end
end
