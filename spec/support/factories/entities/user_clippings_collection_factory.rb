module TestFactories
  class UserClippingsCollectionFactory < BaseFactory

    class << self

      def entity
        Incollage::UserClippingsCollection
      end

      def defaults
        {
            user_id: 5,
            collection_id: 6,
            linked_account_id: 7,
        }
      end
    end
  end
end
