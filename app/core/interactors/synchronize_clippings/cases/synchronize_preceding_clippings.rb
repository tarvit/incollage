module Incollage
  class SynchronizePrecedingClippings < BaseSynchronizeClippings

    def next_clippings
      @clippings_source.preceding_clippings(user_clippings_collection, preceding_clipping)
    end

    def preceding_clipping
      Repository.for_clipping.most_preceding(search_attrs)
    end

  end
end
