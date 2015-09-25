module Incollage
  module Entity
    class Base
      include ActiveModel::Model

      def initialize(attrs = {})
        attrs.each do |attr_name, attr_value|
          public_send("#{attr_name}=", attr_value)
        end
      end

    end
  end
end
