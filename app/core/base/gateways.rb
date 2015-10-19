module Incollage

  class Gateway

    class << self
      def register(type, repo)
        gateways[type] = repo
      end

      def for(type)
        repo = gateways[type.to_sym]
        raise InvalidGatewayTypeError.new(type, self) if repo.nil?
        repo
      end

      def gateways
        @gateways ||= {}
      end

      protected

      class InvalidGatewayTypeError < StandardError
        def initialize(repo_type, gateway_type)
          super("#{gateway_type} for type `#{repo_type}` is not registered.")
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
        gateways.keys
      end
    end

  end

  class Repository < Gateway; end
  class Service < Gateway; end
  class Holder < Gateway; end

end
