module Incollage
  class CollageClippingSearcher

    def initialize(clipping_collection)
      @clipping_collection = clipping_collection
    end

    def search(palette_colors, count)
      all = ClippingFinder.new(@clipping_collection).find_all
      all.sort_by{|cl| -Gateway.for_color_matcher.score(cl.histogram_scores, palette_colors) }[0..(count-1)]
    end

  end
end
