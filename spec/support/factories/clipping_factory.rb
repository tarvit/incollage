module TestFactories
  class ClippingFactory

    class << self

      def get(opts={})
        Incollage::Clipping.new(defaults.merge opts)
      end

      def defaults
        {
            user_id: 1,
            external_id: 1,
            external_created_time: Time.now.to_i,
            collection_id: 1,
            picture_url: 'http://pic.com/pic.png',
            histogram: HistogramFactory.get,
        }
      end

    end
  end
end
