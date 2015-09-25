module Incollage

  module Repository

    class << self
      def register(type, repo)
        repositories[type] = repo
      end

      def for(type)
        repositories[type.to_sym]
      end

      def repositories
        @repositories ||= {}
      end

      def method_missing(m, *args)
        if m.to_s.start_with? 'for_'
          self.for(m.to_s[4..-1])
        else
          super
        end
      end

      private

      def registered_types
        repositories.keys
      end
    end

  end
end
