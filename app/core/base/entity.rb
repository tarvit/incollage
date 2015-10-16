module Incollage
  module Entity
    class Base
      include ActiveModel::Model

      attr_accessor :id

      def initialize(attrs = {})
        attrs.each do |attr_name, attr_value|
          public_send("#{attr_name}=", attr_value)
        end
      end

      def error_messages
        errors.messages
      end

      def check_validity!
        raise EntityIsInvalidError.new(error_messages) unless valid?
      end

    end

    class EntityIsInvalidError < StandardError; end
  end
end
