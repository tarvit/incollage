module Incollage
  class SynchronizeClippings

    def initialize(clippings_collection, clippings_source)
      @clippings_collection = clippings_collection
      @clippings_source = clippings_source
    end

    def sync
      next_clippings = @clippings_source.next_clippings(@clippings_collection, last_clipping)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        next_clippings = @clippings_source.next_clippings(@clippings_collection, last_clipping)
      end
    end

    private

    def last_clipping
      ClippingsFinder.new(@clippings_collection).find_last
    end

  end
end
