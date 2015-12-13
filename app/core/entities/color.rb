module Incollage
  class Color < ValueObject::Base

    values do
      attribute :name, String
      attribute :hex_value, String
    end

    validates_presence_of  :name, :hex_value
  end
end
