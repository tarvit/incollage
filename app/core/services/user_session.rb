module Incollage
  class UserSession
    attr_reader :storage

    def initialize(storage)
      @storage = storage
    end

    def authorized?
      !!@storage[current_user_key]
    end

    def certify_user(user_id)
      @storage[current_user_key] = user_id
    end

    def disallow_current_user
      @storage.delete(current_user_key)
    end

    def current_user
      Repository.for_user.find(id: @storage[current_user_key])
    end

    protected

    def current_user_key
      :current_user_id
    end

  end
end
