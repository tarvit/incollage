require 'spec_helper'

describe Incollage::SynchronizePrecedingClippings do

  before :each do
    @collection = clippings_collection
    @source = clippings_source(@collection)

    data = [
        { external_id: 11, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 12, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 13, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 14, user_id: @collection.user_id, collection_id: @collection.id },
    ].map do |att|
      TestFactories::ClippingFactory.defaults.merge(att)
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end

    @new_data = [
        { external_id: 9, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 10, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 11, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 15, user_id: @collection.user_id, collection_id: @collection.id },
        { external_id: 16, user_id: @collection.user_id, collection_id: @collection.id },
    ].map do |att|
      TestFactories::ClippingFactory.defaults.merge(att)
    end
  end

  it 'should sync preceding clippings' do
    @source.class.clean
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizePrecedingClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    @source.class.add_for_user(@collection.user_id, @collection.id, @new_data)

    Incollage::SynchronizePrecedingClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])

    Incollage::SynchronizePrecedingClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])
  end


  it 'should sync recent clippings' do
    @source.class.clean
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizeRecentClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    @source.class.add_for_user(@collection.user_id, @collection.id, @new_data)

    Incollage::SynchronizeRecentClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,15,16])

    Incollage::SynchronizeRecentClippings.new(@collection, @source).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
  end

  def clippings_collection
    registered_collection_id = Incollage::Service.for_clippings_source_factory.first_collection
    Incollage::UserClippingsCollection.new(1, registered_collection_id)
  end

  def clippings_source(collection)
    Incollage::Service.for_clippings_source_factory.get(collection.id, nil)
  end

end
