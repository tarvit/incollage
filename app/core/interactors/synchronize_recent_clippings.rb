module Incollage
  class SynchronizeRecentClippings

    def initialize(clippings_collection, recent_clippings_source)
      @clippings_collection = clippings_collection
      @clippings_source = recent_clippings_source
    end

    def execute
      next_clippings = @clippings_source.recent_clippings(@clippings_collection, recent_clipping)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        next_clippings = @clippings_source.recent_clippings(@clippings_collection, recent_clipping)
      end
    end

    private

    def recent_clipping
      search_attrs = { user_id: @clippings_collection.user_id, collection_id: @clippings_collection.id }
      Repository.for_clipping.most_recent(search_attrs)
    end

  end
end
