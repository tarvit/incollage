module Incollage
  class ClippingsCollectionsHolder

    def add(id, name, source)
      collection = ClippingsCollection.new(id, name, source)
      add_collection(collection)
    end

    def get_collection(collection_id)
      collections[collection_id]
    end

    alias_method :get, :get_collection

    def get_collection_by_name(name)
      collections.values.find do |c|
        c.name == name
      end
    end

    def added_collections
      collections.values
    end

    def first_collection
      added_collections.first
    end

    protected

    def add_collection(collection)
      collections[collection.id] = collection
    end

    def collections
      @collections ||= {}
    end

  end
end
