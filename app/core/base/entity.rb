module Incollage

  module Validateable
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
    end

    def errors_messages
      errors.messages
    end

    def validate!
      raise BusinessObjectIsInvalidError.new(errors_messages) unless valid?
    end

    class BusinessObjectIsInvalidError < StandardError; end
  end

  module Entity
    class Base
      include Virtus.model
      include Incollage::Validateable
      attribute :id, Integer
    end
  end

  module ValueObject
    class Base
      include Virtus.value_object
      include Incollage::Validateable
    end
  end
end
