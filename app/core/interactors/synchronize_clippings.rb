module Incollage
  class SynchronizeClippings

    def initialize(clippings_collection, clippings_source)
      @clippings_collection = clippings_collection
      @clippings_source = clippings_source
    end

    def sync
      next_clippings = @clippings_source.next_clippings(@clippings_collection, last_clipping_id)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        next_clippings = @clippings_source.next_clippings(@clippings_collection, last_clipping_id)
      end
    end

    private

    def last_clipping_id
      last_synchronized_clipping = ClippingsFinder.new(@clippings_collection).find_last
      last_synchronized_clipping.try(:id) || 0
    end

  end
end
