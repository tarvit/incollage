module TestSupport
  class EmptyClippingsSource

    def initialize(context)

    end

    def recent_clippings(collection, external_id)
      []
    end

    def preceding_clippings(collection, external_id)
      []
    end

  end
end
