module Incollage
  class SynchronizeRecentClippings < BaseSynchronizeClippings

    def next_clippings
      @clippings_source.recent_clippings(@clippings_collection, recent_clipping)
    end

    def recent_clipping
      Repository.for_clipping.most_recent(search_attrs)
    end

  end
end
