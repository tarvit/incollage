module BaseRepositoryTest
  extend ActiveSupport::Concern

  def new_entity(opts={})
    Incollage::Entity::Base.new(opts)
  end

  module ClassMethods

    def test_base_repository

      it 'should CRUD records' do
        expect(@repo.count).to eq(0)

        # save one entity
        @repo.save(new_entity)

        expect(@repo.count).to eq(1)

        # save the second one
        @repo.save(new_entity)

        # count reflects 2 saved records
        expect(@repo.count).to eq(2)

        saved_entities = @repo.all

        # queried list reflects 2 items present
        expect(saved_entities.count).to eq(2)

        first_entity = saved_entities.first
        last_entity = saved_entities.last

        # first, last
        expect(@repo.first.id).to eq(first_entity.id)
        expect(@repo.last.id).to eq(last_entity.id)

        # querying
        expect(@repo.find(id: first_entity.id).id).to eq(first_entity.id)
        expect(@repo.find(id: last_entity.id).id).to eq(last_entity.id)
        expect(@repo.find_all(id: last_entity.id).map &:id).to eq([last_entity.id])

        # existing
        expect(@repo.exists?(id: first_entity.id)).to be_truthy
        expect(@repo.exists?(id: last_entity.id)).to be_truthy
        expect(@repo.exists?(id: -1)).to be_falsey

        # delete one item
        @repo.delete(first_entity)

        # list is affected
        expect(@repo.all.map &:id).to eq([last_entity.id])

        # delete all
        @repo.delete_all

        # the list is empty
        expect(@repo.count).to eq(0)
        expect(@repo.all).to eq([])
      end

    end
  end

end