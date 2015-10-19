require 'spec_helper'

describe Incollage::SynchronizePrecedingClippings do

  before :each do
    @uc_collection = clippings_collection
    @source = clippings_source(@uc_collection)
    @source.class.clean
    @context = {}

    [
        { external_id: 11, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 12, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 13, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 14, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
    ].each do |att|
      attrs = TestFactories::ClippingFactory.defaults.merge(att)
      TestFactories::ClippingFactory.create(attrs)
    end

    @new_data = [
        { external_id: 9, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 10, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 11, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 15, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
        { external_id: 16, user_id: @uc_collection.user_id, collection_id: @uc_collection.collection_id },
    ].map do |att|
      TestFactories::ClippingFactory.defaults.merge(att)
    end
  end

  it 'should sync preceding clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizePrecedingClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    @source.class.add_for_user(@uc_collection.user_id, @uc_collection.collection_id, @new_data)

    Incollage::SynchronizePrecedingClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])

    Incollage::SynchronizePrecedingClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])
  end


  it 'should sync recent clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizeRecentClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    @source.class.add_for_user(@uc_collection.user_id, @uc_collection.collection_id, @new_data)

    Incollage::SynchronizeRecentClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,15,16])

    Incollage::SynchronizeRecentClippings.new(@uc_collection, @context).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
  end

  def clippings_collection
    registered_collection_id = Incollage::Holder.for_clippings_collections.first_collection.id
    Incollage::UserClippingsCollection.new(1, registered_collection_id)
  end

  def clippings_source(collection)
    Incollage::Holder.for_clippings_collections.get(collection.collection_id).source
  end

end
