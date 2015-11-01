module TestFactories
  class PictureFactory < BaseFactory

    class << self

      def entity
        Incollage::Picture
      end

      def defaults
        {
            url: 'http://pic.com/pic.png',
            source_id: 1,
            external_id: 1,
            external_created_time: Time.now.to_i,
            histogram: HistogramFactory.get,
        }
      end

    end
  end
end
