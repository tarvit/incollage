module LinkedAccountRepositoryTest
  extend ActiveSupport::Concern
  include BaseRepositoryTest

  def new_entity(opts={})
    TestFactories::LInkedAccountFactory.get(opts)
  end

  module ClassMethods

    def test_linked_account_repository

      context 'Base' do
        test_base_repository
      end

    end
  end
end
