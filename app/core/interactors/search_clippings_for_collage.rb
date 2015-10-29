module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      all = ClippingsFinder.new(@options).find_all
      results = all.sort_by{|cl| -Service.for_color_matcher.score(cl.histogram.scores, @palette_colors) }
      prepare(results)
    end

    protected

    def prepare(results)
      results[0..(@count-1)].map do |clipping|
        { id: clipping.id, picture_url: clipping.picture_url }
      end
    end
  end
end
