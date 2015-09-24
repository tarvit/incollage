module Incollage

  class UserCreator

    def initialize(user_data)
      @user_data = user_data
    end

    def create
      Repository.for(:user).save(@user_data)
    end

  end

end
