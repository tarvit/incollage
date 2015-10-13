module TestSupport
  class FakeHistogramMaker

    def initialize(picture_url, colors_count=10, depth=1)

    end

    def make
      TestFactories::HistogramFactory.defaults
    end

  end
end

