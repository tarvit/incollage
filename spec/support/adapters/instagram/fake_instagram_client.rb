module TestSupport
  class FakeInstagramClient < TestSupport::FakeAbstractService

    def user_recent_media(*args)
      fake_feed
    end

    def user_media_feed(*args)
      fake_feed
    end

    def user
      OpenStruct.new(id: 10)
    end

    protected

    def fake_feed
      [ TestFactories::Instagram::MediaItemFactory.get ]
    end
  end
end
