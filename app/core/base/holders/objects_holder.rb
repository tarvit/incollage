module Incollage
  module ObjectsHolder

    class Base
      def add(object)
        add_to_content(object)
      end

      def get(id)
        content[id]
      end

      def has?(id)
        !!get(id)
      end

      def added
        content.values
      end

      protected

      def content
        @content ||= {}
      end

      def error_message(object)
        "Object ID #{object.id} is occupied in the Holder #{self.class.name} already!"
      end

      def add_to_content(object)
        raise ArgumentError.new(error_message(object)) if get(object.id)
        content[object.id] = object
      end
    end
  end
end

