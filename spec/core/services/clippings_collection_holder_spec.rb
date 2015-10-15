require 'spec_helper'

describe Incollage::ClippingsCollectionHolder do

  before :each do
    @source = TestSupport::EmptyClippingsSource
    @holder = Incollage::ClippingsCollectionHolder.new
    @context = OpenStruct.new
    @collection_args = [ 15, :test, @source ]
    @clippings_collection = Incollage::ClippingsCollection.new(*@collection_args)
  end

  it 'should add/get clippings collections' do
    expect(@holder.added_collections.count).to eq(0)

    @holder.add(*@collection_args)
    expect(@holder.added_collections.count).to eq(1)

    # duplicated adding of the collection with the same ID
    @holder.add(*@collection_args)
    expect(@holder.added_collections.count).to eq(1)

    expect(@holder.get(@clippings_collection.id).id).to eq(@clippings_collection.id)

    expect(@holder.added_collections.map &:id).to eq([ @clippings_collection.id ])
    expect(@holder.first_collection.id).to eq(@clippings_collection.id)
  end

end
