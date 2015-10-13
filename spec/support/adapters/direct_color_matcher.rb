module TestSupport
  class DirectColorMatcher

    def score(histogram_scores, palette_colors)
      scores = palette_colors.map do |pc|
        histogram_scores.values.include?(pc) ? histogram_scores.key(pc) : 0
      end
      scores.inject(:+)
    end

  end
end
