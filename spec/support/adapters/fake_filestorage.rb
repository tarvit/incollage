module TestSupport
  class FakeFileStorage

    def initialize(fakes={})
      @fakes = fakes
    end

    def save_file(url)
      fakes[url]
    end

    def fakes
      @fakes ||= {}
    end
  end
end
