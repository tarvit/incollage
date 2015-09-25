module Incollage
  module Entity
    class Base
      include ActiveModel::Model

      attr_accessor :id
      validates_presence_of :id

      def initialize(attrs = {})
        attrs.each do |attr_name, attr_value|
          public_send("#{attr_name}=", attr_value)
        end
      end

      def error_messages
        errors.messages
      end

    end
  end
end
