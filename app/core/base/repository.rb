module Incollage

  module Repository

    class << self
      def register(type, repo)
        repositories[type] = repo
      end

      def for(type)
        repo = repositories[type.to_sym]
        raise InvalidRepoTypeError.new(type) if repo.nil?
        repo
      end

      def repositories
        @repositories ||= {}
      end

      protected

      class InvalidRepoTypeError < StandardError
        def initialize(type)
          super("Repository type `#{type}` is not registered.")
        end
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
