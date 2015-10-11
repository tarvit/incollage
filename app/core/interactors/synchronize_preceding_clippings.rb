module Incollage
  class SynchronizePrecedingClippings

    def initialize(clippings_collection, preceding_clippings_source)
      @clippings_collection = clippings_collection
      @clippings_source = preceding_clippings_source
    end

    def execute
      next_clippings = @clippings_source.preceding_clippings(@clippings_collection, preceding_clipping)
      while !next_clippings.empty?
        next_clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        next_clippings = @clippings_source.preceding_clippings(@clippings_collection, preceding_clipping)
      end
    end

    private

    def preceding_clipping
      search_attrs = { user_id: @clippings_collection.user_id, collection_id: @clippings_collection.id }
      Repository.for_clipping.most_preceding(search_attrs)
    end

  end
end
