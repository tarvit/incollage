module Incollage

  class CollageMaker

    attr_reader :files, :output_path

    def initialize(files, output_path)
      @files = files
      @output_path = output_path
    end

    def make
      system(command)
      File.open(output_path)
    end

    protected

    def command
      "montage #{files.join(' ')} -size 300x300 -geometry 300x300-10-10 +polaroid -tile x1 -gravity center -background none #{output_path}"
    end

  end
end
