module Incollage
  class ExternalClippingsCollectionsHolder

    def add(attrs)
      collection = ExternalClippingsCollection.new(attrs)
      collection.check_validity!
      add_collection(collection)
    end

    def get(identifier)
      return get_collection_by_id(identifier) if identifier.is_a?(Numeric)
      return get_collection_by_name(identifier) if identifier.is_a?(Symbol)
      nil
    end

    def get_collection_by_id(collection_id)
      collections[collection_id]
    end

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
