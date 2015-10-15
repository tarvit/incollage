module TestFactories
  class ClippingFactory < RepositoryFactory

    class << self

      def entity
        Incollage::Clipping
      end

      def repository
        Incollage::Repository.for_clipping
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
