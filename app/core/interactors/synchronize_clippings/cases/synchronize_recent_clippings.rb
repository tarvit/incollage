module Incollage
  class SynchronizeRecentClippings < BaseSynchronizeClippings

    def next_clippings
      @clippings_source.recent_clippings(user_clippings_collection, recent_clipping, context)
    end

    def recent_clipping
      Repository.for_clipping.most_recent(search_attrs)
    end

  end
end
