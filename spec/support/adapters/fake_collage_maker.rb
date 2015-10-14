module TestSupport
  class FakeCollageMaker

    attr_reader :files, :output_path

    def initialize(files, output_path)
      @files = files
      @output_path = output_path
    end

    def make
      files.first
    end

    def self.get(*args)
      new *args
    end

  end
end
