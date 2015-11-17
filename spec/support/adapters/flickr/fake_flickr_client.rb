module TestSupport
  class FakeFlickrClient
    class Photos < TestSupport::FakeAbstractService

      def search(*args)
        fake_feed
      end

      protected

      def fake_feed
        [ TestFactories::Flickr::MediaItemFactory.get ]
      end
    end

    def photos
      Photos.new
    end
  end
end
