module Incollage
  class SynchronizeClippings

    def initialize(clipping_collection)
      @clipping_collection = clipping_collection
      @clippings_source = Gateway.for_clippings_source
    end

    def sync
      next_clippings = @clippings_source.next_clippings(@clipping_collection, last_clipping_id)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        next_clippings = @clippings_source.next_clippings(@clipping_collection, last_clipping_id)
      end
    end

    private

    def last_clipping_id
      last_synchronized_clipping = FindClippings.new(@clipping_collection).find_last
      last_synchronized_clipping.id || 0
    end

  end
end
