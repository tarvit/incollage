module TestFactories
  class LinkedAccountFactory < RepositoryFactory

    class << self

      def entity
        Incollage::LinkedAccount
      end

      def repository
        Incollage::Repository.for_linked_account
      end

      def defaults
        {
            user_id: 25,
            external_user_id: '75225',
            external_account_id: '75225',
            external_meta_info: { token: 'test_token', user: { username: 'jdex' } },
        }
      end

    end
  end
end
