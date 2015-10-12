module Incollage
  class MakeCollage

    def initialize(files)
      @files = files
    end

    def execute
      Gateway.for_collage_maker.new(@files).make
    end

  end
end
