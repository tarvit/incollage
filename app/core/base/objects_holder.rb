module Incollage
  module ObjectsHolder

    class Base
      def add(object)
        add_to_content(object)
      end

      def get(id)
        content[id]
      end

      def added
        content.values
      end

      def content
        @content ||= {}
      end

      protected

      def error_message(object)
        "Object ID #{object.id} is occupied in the Holder #{self.class.name} already!"
      end

      def add_to_content(object)
        raise ArgumentError.new(error_message(object)) if get(object.id)
        content[object.id] = object
      end
    end

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

