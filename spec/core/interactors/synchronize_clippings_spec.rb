require 'spec_helper'

describe Incollage::SynchronizeClippings do

  before :each do

    data = [
        { id: 1, user_id: 1, collection_id: 2 },
        { id: 2, user_id: 1, collection_id: 1 },
        { id: 3, user_id: 2, collection_id: 2 },
        { id: 4, user_id: 1, collection_id: 1 },
    ].map do |att|
      att.merge!(file_path: 'some_path', histogram: Incollage::Histogram.new(1 => '00ff00'))
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end

    @new_data = [
        { id: 1, user_id: 1, collection_id: 2 },
        { id: 5, user_id: 1, collection_id: 2 },
    ].map do |att|
      att.merge!(file_path: 'some_path', histogram: Incollage::Histogram.new(1 => '00ff00'))
    end
  end

  it 'should sync clippings' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)
    collection = Incollage::ClippingsCollection.new(1, 2)

    Incollage::SynchronizeClippings.new(collection).sync
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    Incollage::Gateway.for_clippings_source.class.add_for_user(collection.user_id, collection.id, @new_data)

    Incollage::SynchronizeClippings.new(collection).sync
    expect(Incollage::Repository.for_clipping.count).to eq(5)

    Incollage::SynchronizeClippings.new(collection).sync
    expect(Incollage::Repository.for_clipping.count).to eq(5)
  end

end
