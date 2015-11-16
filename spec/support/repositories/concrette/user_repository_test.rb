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

      context 'Validation' do
        it 'should not save an entity without username' do
          expect(->{
            @repo.save(new_entity(username: nil))
          }).to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)
        end

        it 'should not save user without password' do
          expect(->{
            @repo.save(new_entity(password: 'q1w2e3r4t5'))
          }).to change{ @repo.count }.by(1)

          expect(->{
            @repo.save(new_entity(password: nil))
          }).to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)
        end

        it 'should save an entities with uniq usernames only' do
          # create user with an unique username
          expect(->{
            @repo.save(new_entity(username: 'some'))
          }).to change{ @repo.count }.by(1)

          # the existing username causes error on saving
          expect(->{
            @repo.save(new_entity(username: 'some'))
          }).to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)
        end

      end
    end
  end
end
