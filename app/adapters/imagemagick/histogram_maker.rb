module Imagemagick

  class HistogramMaker
    require 'colorscore'

    def initialize(picture_url, colors_count = 10, depth = 1)
      @picture_url = picture_url
      @colors_count, @depth = colors_count, depth
    end

    def make
      histogram = Colorscore::Histogram.new(@picture_url, @colors_count, @depth)
      scores = histogram.scores.map do |(score, color_rgb)|
        [ score, color_rgb.hex ]
      end
      Hash[scores]
    end

  end
end
