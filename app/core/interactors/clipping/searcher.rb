module Incollage
  class CollageClippingSearcher

    def initialize(user_id, collection_id)
      @user_id, @collection_id = user_id, collection_id
    end

    def search(palette_colors, count)
      all = ClippingFinder.new(@user_id, @collection_id).find_all
      all.sort_by{|cl| -Gateway.for_color_matcher.score(cl.histogram_scores, palette_colors) }[0..(count-1)]
    end

    protected

    def search_attrs
      { user_id: @user_id, collection_id: @collection_id }
    end

  end
end
