module Incollage
  class ClippingAdder

    def initialize(clipping_data)
      @clipping_data = clipping_data
    end

    def add
      clipping = Clipping.new(@clipping_data)
      Repository.for_clipping.save(clipping)
    end

  end
end
