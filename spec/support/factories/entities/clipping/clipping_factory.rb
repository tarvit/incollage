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
            collection_id: 1,
            linked_account_id: 1,
            picture: PictureFactory.get,
        }
      end

    end
  end
end
