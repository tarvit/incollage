module Incollage

  class CollageMaker

    def initialize(files)
      @files = files
    end

    def make
     File.open(@files.first)
    end

  end
end
