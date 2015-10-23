module BaseRepositoryTest
  extend ActiveSupport::Concern

  def new_entity(opts={})
    Incollage::Entity::Base.new(opts)
  end

  module ClassMethods

    def test_base_repository

      context 'no data' do

        it 'should save & count entities' do
          expect(@repo.count).to eq(0)

          # save one entity
          @repo.save(new_entity)

          # count reflects one record
          expect(@repo.count).to eq(1)

          # save the second one
          @repo.save(new_entity)

          # count reflects 2 saved records
          expect(@repo.count).to eq(2)
        end

      end

      context 'two records' do

        before :each do
          @first_entity = @repo.save(new_entity)
          @last_entity = @repo.save(new_entity)
        end

        it 'should query all' do
          saved_entities = @repo.all
          # a queried list reflects 2 items present
          expect(saved_entities.count).to eq(2)
        end

        it 'should query first/last' do
          expect(@repo.first.id).to eq(@first_entity.id)
          expect(@repo.last.id).to eq(@last_entity.id)
        end

        it 'should query by attrs' do
          expect(@repo.find(id: @first_entity.id).id).to eq(@first_entity.id)
          expect(@repo.find(id: @last_entity.id).id).to eq(@last_entity.id)
          expect(@repo.find_all(id: @last_entity.id).map &:id).to eq([@last_entity.id])
          expect(@repo.count(id: @last_entity.id)).to eq(1)
        end

        it 'should respond to exists?' do
          expect(@repo.exists?(id: @first_entity.id)).to be_truthy
          expect(@repo.exists?(id: @last_entity.id)).to be_truthy
          expect(@repo.exists?(id: -1)).to be_falsey
        end

        it 'should delete an item' do
          # delete one item
          @repo.delete(@first_entity)

          # the list is affected
          expect(@repo.all.map &:id).to eq([@last_entity.id])
        end

        it 'should delete all' do
          @repo.delete_all

          # the list is empty
          expect(@repo.count).to eq(0)
          expect(@repo.all).to eq([])
        end

        it 'should add ID after save' do
          entity = new_entity
          entity.id = nil
          result_entity = @repo.save(entity)
          expect(result_entity.id).to be
        end
      end
    end
  end
end
