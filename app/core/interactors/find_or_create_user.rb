module Incollage
  class FindOrCreateUser

    def initialize(user_data)
      @user_data = user_data
    end

    def execute
      Repository.for_user.find(@user_data) || Repository.for_user.save(build_entity)
    end

    private

    def build_entity
      User.new(@user_data)
    end

  end
end
