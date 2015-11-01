module TestSupport
  class FakeHistogramMaker

    def initialize
    end

    def make(picture_url)
      TestFactories::HistogramFactory.defaults
    end

  end
end

