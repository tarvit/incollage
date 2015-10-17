module Incollage
  module Entity
    class Base
      include ActiveModel::Model

      attr_accessor :id

      def errors_messages
        errors.messages
      end

      def check_validity!
        raise EntityIsInvalidError.new(errors_messages) unless valid?
      end

    end

    class EntityIsInvalidError < StandardError; end
  end
end
