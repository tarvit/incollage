module Incollage
  class ClippingsCollectionHolder

    def add_source(collection_id, source)
      validate_source!(source)
      sources[collection_id] = source
    end

    def get_source(collection_id, context)
      sources[collection_id].new(context)
    end

    alias_method :get, :get_source

    def sources_count
      sources.values.count
    end

    def registered_collections
      sources.keys
    end

    def first_collection
      registered_collections.first
    end

    protected

    def sources
      @sources ||= {}
    end

    def validate_source!(source)
      source_methods.each do |method|
        has_method = source.public_instance_methods.include?(method)
        raise NoMethodError.new("#{ method } not found in #{ source }", method) unless has_method
      end
    end

    def source_methods
      [ :recent_clippings, :preceding_clippings ]
    end
  end
end
