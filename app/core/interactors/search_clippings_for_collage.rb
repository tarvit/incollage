module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      all = ClippingsFinder.new(@options).find_all
      results = all.sort_by{|cl| -Service.for_color_matcher.score(cl.histogram.scores, @palette_colors) }
      results[0..20].sort_by{ rand }[0..(@count-1)]
    end

  end
end
