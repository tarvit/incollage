require 'spec_helper'

describe Incollage::CollageClippingSearcher do

  before :each do
    data = [
        { id: 1, histogram: Incollage::Histogram.new({ 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff' }) },
        { id: 2, histogram: Incollage::Histogram.new({ 0.7 => 'ff0000', 0.2 => '00ff00', 0.1 => '0000ff' }) },
        { id: 3, histogram: Incollage::Histogram.new({ 0.9 => 'ff0000', 0.1 => '00ff00', 0.0 => '0000ff' }) },
    ].map do |att|
      att.merge!( file_path: 'some_path', user_id: 1, collection_id: 1 )
    end

    data.each do |att|
      Incollage::ClippingAdder.new(att).add
    end
  end

  it 'should search clippings by colors' do
    collection = Incollage::ClippingsCollection.new(1, 1, [])
    searcher = Incollage::CollageClippingSearcher.new(collection)

    expect(searcher.search( [ 'ff0000' ], 1 ).map(&:id)).to eq([ 3 ])
    expect(searcher.search( [ '00ff00' ], 1 ).map(&:id)).to eq([ 1 ])
    expect(searcher.search( [ '0000ff' ], 1 ).map(&:id)).to eq([ 2 ])

    expect(searcher.search( [ 'ff0000', '00ff00' ], 2 ).map(&:id)).to eq([ 3, 1 ])
    expect(searcher.search( [ '0000ff' ], 3 ).map(&:id)).to eq([ 2, 1, 3 ])
  end

end
