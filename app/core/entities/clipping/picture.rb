module Incollage
  class Picture < ValueObject::Base

    values do
      attribute :url, String
      attribute :histogram, Histogram
    end

    validates_presence_of  :url, :histogram
  end
end
