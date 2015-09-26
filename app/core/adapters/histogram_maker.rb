module Incollage

  class HistogramMaker
    require 'colorscore'

    def initialize(file_path, colors_count = 10, depth = 1)
      @file_path = file_path
      @colors_count, @depth = colors_count, depth
    end

    def make
      histogram = Colorscore::Histogram.new(@file_path, @colors_count, @depth)
      scores = histogram.scores.map do |(score, color_rgb)|
        [ score, color_rgb.hex ]
      end
      Hash[scores]
    end

  end
end
