module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      all = Repository.for_clipping.find_all(@options)
      results = all.sort_by{|cl| -Service.for_color_matcher.score(cl.picture.histogram.scores, @palette_colors) }
      prepare(results)
    end

    protected

    def prepare(results)
      results[0..(@count-1)]
    end
  end
end
