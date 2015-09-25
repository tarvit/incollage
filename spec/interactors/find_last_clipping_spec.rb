require 'spec_helper'

describe Incollage::ClippingFinder do

  before :each do

    data = [
        { id: 1, user_id: 1, collection_id: 2 },
        { id: 2, user_id: 1, collection_id: 1 },
        { id: 3, user_id: 2, collection_id: 2 },
        { id: 4, user_id: 1, collection_id: 1 },
    ].map do |att|
      att.merge!(file_path: 'some_path', histogram_scores: { 1 => '00ff00' })
    end

    data.each do |att|
      Incollage::ClippingAdder.new(att).add
    end
  end

  it 'should find last clipping of a user' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    expect(Incollage::ClippingFinder.new(1, 1).find_last.id).to eq(4)
    expect(Incollage::ClippingFinder.new(1, 2).find_last.id).to eq(1)
    expect(Incollage::ClippingFinder.new(2, 2).find_last.id).to eq(3)

    expect(Incollage::ClippingFinder.new(2, 1).find_last).to be_nil
    expect(Incollage::ClippingFinder.new(3, 1).find_last).to be_nil
    expect(Incollage::ClippingFinder.new(1, 3).find_last).to be_nil
  end

end
