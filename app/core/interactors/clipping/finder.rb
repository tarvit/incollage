module Incollage
  class ClippingFinder

    def initialize(user_id, collection_id)
      @user_id, @collection_id = user_id, collection_id
    end

    def find
      Repository.for_clipping.find(user_id: @user_id, collection_id: @collection_id)
    end

    def find_last
      Repository.for_clipping.find_last(user_id: @user_id, collection_id: @collection_id)
    end

  end
end
