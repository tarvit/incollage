module Incollage
  class BaseSynchronizeClippings
    attr_reader :user_clippings_collection

    def initialize(user_clippings_collection, context=nil)
      @user_clippings_collection = user_clippings_collection
      @clippings_source = Service.for_clippings_collection_holder.get(user_clippings_collection.collection_id, context)
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
      { user_id: user_clippings_collection.user_id, collection_id: user_clippings_collection.collection_id }
    end

  end
end
