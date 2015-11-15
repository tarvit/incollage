module TestFactories
  class PictureFactory < BaseFactory

    class << self

      def entity
        Incollage::Picture
      end

      def defaults
        {
            url: 'http://pic.com/pic.png',
            histogram: HistogramFactory.get,
        }
      end

    end
  end
end
