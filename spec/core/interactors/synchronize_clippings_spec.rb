require 'spec_helper'

describe Incollage::SynchronizeClippings do

  before :each do

    data = [
        { id: 1, user_id: 1, collection_id: 2 },
        { id: 2, user_id: 1, collection_id: 1 },
        { id: 3, user_id: 2, collection_id: 2 },
        { id: 4, user_id: 1, collection_id: 1 },
    ].map do |att|
      ClippingFactory.defaults.merge(att)
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end

    @new_data = [
        { id: 1, user_id: 1, collection_id: 2 },
        { id: 5, user_id: 1, collection_id: 2 },
    ].map do |att|
      ClippingFactory.defaults.merge(att)
    end
  end

  before :each do
    @source = Incollage::ClippingSource::InMemory::Base
  end

  it 'should sync clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    collection = Incollage::ClippingsCollection.new(1, 2)

    Incollage::SynchronizeClippings.new(collection, @source.new).sync
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    @source.add_for_user(collection.user_id, collection.id, @new_data)

    Incollage::SynchronizeClippings.new(collection, @source.new).sync
    expect(Incollage::Repository.for_clipping.count).to eq(5)

    Incollage::SynchronizeClippings.new(collection, @source.new).sync
    expect(Incollage::Repository.for_clipping.count).to eq(5)
  end

end
