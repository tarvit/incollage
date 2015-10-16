module UserRepositoryTest
  extend ActiveSupport::Concern
  include BaseRepositoryTest

  def new_entity(opts={})
    TestFactories::UserFactory.get(opts)
  end

  module ClassMethods

    def test_user_repository

      context 'Base' do
        test_base_repository
      end

      context 'Methods' do

        it 'Username' do
          expect(@repo.username_occupied?('johndoe')).to be_falsey

        end

      end

    end
  end
end
