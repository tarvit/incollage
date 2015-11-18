module Incollage
  module ObjectsHolder

    class EntityBase < Base

      def add(attrs)
        entity = entity_klass.new(attrs)
        entity.validate!
        super(entity)
      end

      protected

      def entity_klass
        raise NotImplemented
      end
    end

    class NamedEntityBase < EntityBase

      def get(identifier)
        return get_by_id(identifier) if identifier.is_a?(Numeric)
        return get_by_name(identifier) if identifier.is_a?(Symbol)
        nil
      end

      protected

      def get_by_id(collection_id)
        content[collection_id]
      end

      def get_by_name(name)
        added.find do |entity|
          entity.name == name
        end
      end
    end
  end
end
