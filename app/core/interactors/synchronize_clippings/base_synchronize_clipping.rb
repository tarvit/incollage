module Incollage
  class BaseSynchronizeClippings

    def initialize(clippings_collection, context=nil)
      @clippings_collection = clippings_collection
      @clippings_source = Service.for_clippings_source_factory.get(clippings_collection.id, context)
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
        !Repository.for_clipping.find(search_attrs.merge(external_id: clipping[:external_id]))
      end
    end

    def search_attrs
      { user_id: @clippings_collection.user_id, collection_id: @clippings_collection.id }
    end

  end
end
