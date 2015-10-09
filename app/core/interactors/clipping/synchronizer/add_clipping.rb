module Incollage
  class AddClipping

    def initialize(clipping_data)
      @clipping_data = clipping_data
    end

    def execute
      clipping = Clipping.new(@clipping_data)
      Repository.for_clipping.save(clipping)
    end

  end
end
