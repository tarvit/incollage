module Incollage
  class ExternalClippingsCollectionsHolder < ObjectsHolder::NamedEntityBase

    def added_collections
      added
    end

    def first_collection
      added.first
    end

    protected

    def entity_klass
      ExternalClippingsCollection
    end
  end
end
