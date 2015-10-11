module Incollage
  class BaseSynchronizeClippings

    def initialize(clippings_collection, preceding_clippings_source)
      @clippings_collection = clippings_collection
      @clippings_source = preceding_clippings_source
    end

    def execute
      clippings = non_imported_clippings(next_clippings)

      while !clippings.empty?
        clippings.each do |clipping|
          AddClipping.new(clipping).execute
        end
        clippings = non_imported_clippings(next_clippings)
      end
    end

    protected

    def next_clippings
      raise NotImplementedError
    end

    def non_imported_clippings(clippings)
      clippings.select do |clipping|
        !Repository.for_clipping.find(search_attrs.merge(external_id: clipping[:id]))
      end
    end

    def search_attrs
      { user_id: @clippings_collection.user_id, collection_id: @clippings_collection.id }
    end

  end
end
