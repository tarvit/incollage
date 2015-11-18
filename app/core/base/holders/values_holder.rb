module Incollage

  module ValuesHolder
    class Base
      def add(object)
        add_to_content(object)
      end

      def has?(id)
        !!get(id)
      end

      def added
        content.keys
      end

      protected

      def get(object)
        object if content[object]
      end

      def content
        @content ||= {}
      end

      def error_message(object)
        "Value #{object} is occupied in the Holder #{self.class.name} already!"
      end

      def add_to_content(object)
        raise ArgumentError.new(error_message(object)) if has?(object)
        content[object] = true
      end
    end
  end
end
