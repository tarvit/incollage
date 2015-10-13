module Incollage
  class MakeCollage

    def initialize(files, path)
      @files = files
      @path = path
    end

    def execute
      Gateway.for_collage_maker_factory.new(@files, @path).make
    end

  end
end