module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      all = ClippingsFinder.new(@options).find_all
      all.sort_by{|cl| -Service.for_color_matcher.score(cl.histogram.scores, @palette_colors) }[0..(@count-1)]
    end

  end
end
