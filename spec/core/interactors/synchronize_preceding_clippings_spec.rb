require 'spec_helper'

describe Incollage::SynchronizePrecedingClippings do

  before :each do

    data = [
        { external_id: 11, user_id: 1, collection_id: 2 },
        { external_id: 12, user_id: 1, collection_id: 2 },
        { external_id: 13, user_id: 1, collection_id: 2 },
        { external_id: 14, user_id: 1, collection_id: 2 },
    ].map do |att|
      ClippingFactory.defaults.merge(att)
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end

    @new_data = [
        { external_id: 9, user_id: 1, collection_id: 2 },
        { external_id: 10, user_id: 1, collection_id: 2 },
        { external_id: 11, user_id: 1, collection_id: 2 },
        { external_id: 15, user_id: 1, collection_id: 2 },
        { external_id: 16, user_id: 1, collection_id: 2 },
    ].map do |att|
      ClippingFactory.defaults.merge(att)
    end
  end

  before :each do
    @source = Incollage::ClippingSource::InMemory::PrecedingSource
  end

  it 'should sync precending clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    collection = Incollage::ClippingsCollection.new(1, 2)

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    @source.add_for_user(collection.user_id, collection.id, @new_data)

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])
  end

end
