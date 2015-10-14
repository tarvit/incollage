require 'spec_helper'

describe Incollage::ClippingsSourceFactory do

  before :each do
    @source = TestSupport::EmptyClippingSource
    @factory = Incollage::ClippingsSourceFactory.new
    @context = OpenStruct.new
    @collection = Incollage::UserClippingsCollection.new(1, 2)
  end

  context 'Valid Source' do

    it 'should add/get clippings sources' do
      expect(@factory.sources_count).to eq(0)

      @factory.add_source(@collection.id, @source)

      expect(@factory.sources_count).to eq(1)

      source = @factory.get(@collection.id, @context)
      expect(source).to be_a(@source)

      expect(@factory.registered_collections).to eq([ 2 ])
      expect(@factory.first_collection).to eq(2)
    end

  end

  context 'Invalid Source' do
    it 'should not allow to add invalid clippings sources' do
      expect(@factory.sources_count).to eq(0)

      expect(->{
        @factory.add_source(@collection.id, OpenStruct.new)
      }).to raise_error(NoMethodError)

      expect(@factory.sources_count).to eq(0)
    end
  end

end
