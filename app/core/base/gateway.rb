module Incollage

  class Gateway

    class << self
      def register(type, repo)
        gateways[type] = repo
      end

      def for(type)
        repo = gateways[type.to_sym]
        raise InvalidGatewayTypeError.new(type) if repo.nil?
        repo
      end

      def gateways
        @gateways ||= {}
      end

      protected

      class InvalidGatewayTypeError < StandardError
        def initialize(type)
          super("Gateway for type `#{type}` is not registered.")
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
end