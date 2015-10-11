require 'spec_helper'

describe Incollage::SynchronizePrecedingClippings do

  before :each do

    data = [
        { id: 11, user_id: 1, collection_id: 2 },
        { id: 12, user_id: 1, collection_id: 2 },
        { id: 13, user_id: 1, collection_id: 2 },
        { id: 14, user_id: 1, collection_id: 2 },
    ].map do |att|
      att[:external_id] = att[:id]
      ClippingFactory.defaults.merge(att)
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end

    @new_data = [
        { id: 9, user_id: 1, collection_id: 2 },
        { id: 10, user_id: 1, collection_id: 2 },
        { id: 11, user_id: 1, collection_id: 2 },
        { id: 15, user_id: 1, collection_id: 2 },
        { id: 16, user_id: 1, collection_id: 2 },
    ].map do |att|
      att[:external_id] = att[:id]
      ClippingFactory.defaults.merge(att)
    end
  end

  before :each do
    @source = Incollage::ClippingSource::InMemory::PrecedingSource
    @source.clean
  end

  it 'should sync precending clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    collection = Incollage::ClippingsCollection.new(1, 2)

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:id)).to eq([11,12,13,14])

    @source.add_for_user(collection.user_id, collection.id, @new_data)

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:id)).to eq([11,12,13,14,9,10])

    Incollage::SynchronizePrecedingClippings.new(collection, @source.new).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:id)).to eq([11,12,13,14,9,10])
  end

end
