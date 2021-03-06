require 'spec_helper'

describe Incollage::SynchronizePrecedingClippings do
  let(:uc_collection) do
    Incollage::UserClippingsCollection.new(clippings_collection_attrs)
  end

  let(:source) do
    Incollage::Holder.for_clippings_collections.get(uc_collection.collection_id).source
  end

  let(:clippings_collection_attrs) do
    registered_collection_id = Incollage::Holder.for_clippings_collections.first_collection.id
    { user_id: 1, collection_id: registered_collection_id, linked_account_id: 1 }
  end

  let(:new_data) do
    [
        { external_id: 9, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 10, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 11, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 15, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 16, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
    ].map do |att|
      TestFactories::ClippingFactory.defaults.merge(att)
    end
  end

  before do |example|
    example.with_holders
    example.with_clipping_repo

    source.class.clean
    create_clippings
  end

  it 'should sync preceding clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizePrecedingClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    source.class.add_for_user(uc_collection.user_id, uc_collection.collection_id, new_data)

    Incollage::SynchronizePrecedingClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])

    Incollage::SynchronizePrecedingClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,9,10])
  end

  it 'should sync recent clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::SynchronizeRecentClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14])

    source.class.add_for_user(uc_collection.user_id, uc_collection.collection_id, new_data)

    Incollage::SynchronizeRecentClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
    expect(Incollage::Repository.for_clipping.all.map(&:external_id)).to eq([11,12,13,14,15,16])

    Incollage::SynchronizeRecentClippings.new(clippings_collection_attrs).execute
    expect(Incollage::Repository.for_clipping.count).to eq(6)
  end

  private

  def create_clippings
    [
        { external_id: 11, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 12, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 13, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
        { external_id: 14, user_id: uc_collection.user_id, collection_id: uc_collection.collection_id },
    ].each do |att|
      attrs = TestFactories::ClippingFactory.defaults.merge(att)
      TestFactories::ClippingFactory.create(attrs)
    end
  end
end
