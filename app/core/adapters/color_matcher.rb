module Incollage

  class DirectColorMatcher

    def score(histogram_scores, palette_colors)
      scores = palette_colors.map do |pc|
        histogram_scores.values.include?(pc) ? histogram_scores.key(pc) : 0
      end
      scores.inject(:+)
    end

  end

  class PaletteColorMatcher
    require 'color'
    require 'colorscore'

    def score(histogram_scores, palette_colors)
      palette = Colorscore::Palette.from_hex(palette_colors)
      phc = palette_histogram_scores(histogram_scores)
      scores = palette.scores(phc, 1)
      scores.empty? ? 0 : scores.map{|sc| sc.first.to_f }.inject(:+)
    end

    protected

    def palette_histogram_scores(histogram_scores)
      histogram_scores.to_a.map{|(score, hex_color)| [score, Color::RGB.from_html(hex_color) ] }
    end

  end
end
