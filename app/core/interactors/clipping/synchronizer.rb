module Incollage
  class ClippingSynchronizer

    def initialize(user_id, collection_id)
      @user_id, @collection_id = user_id, collection_id
      @clipping_collection = Gateway.for_clipping_collection.new(user_id, collection_id)
    end

    def sync
      next_clippings = @clipping_collection.next_clippings(last_clipping_id)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          ClippingAdder.new(clipping).add
        end
        next_clippings = @clipping_collection.next_clippings(last_clipping_id)
      end
    end

    private

    def last_clipping_id
      last_synchronized_clipping = ClippingFinder.new(@user_id, @collection_id).find_last
      last_synchronized_clipping.id || 0
    end

  end
end
