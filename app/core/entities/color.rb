module Incollage
  class Color < Entity::Base

    attribute :name, String
    attribute :hex_value, String

    validates_presence_of  :name, :hex_value
  end
end
