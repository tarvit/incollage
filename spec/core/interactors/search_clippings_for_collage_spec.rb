require 'spec_helper'

describe Incollage::SearchClippingsForCollage do

  before :each do
    [
        { id: 1, histogram: Incollage::Histogram.new({ 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff' }) },
        { id: 2, histogram: Incollage::Histogram.new({ 0.7 => 'ff0000', 0.2 => '00ff00', 0.1 => '0000ff' }) },
        { id: 3, histogram: Incollage::Histogram.new({ 0.9 => 'ff0000', 0.1 => '00ff00', 0.0 => '0000ff' }) },
    ].each do |att|
      attrs = TestFactories::ClippingFactory.defaults.merge(att)
      TestFactories::ClippingFactory.create(attrs)
    end
  end

  it 'should search clippings by colors' do
    scope = { user_id: 1, collection_id: 1 }

    expect(searcher(scope, [ 'ff0000' ], 1 ).execute.map(&:id)).to eq([ 3 ])
    expect(searcher(scope, [ '00ff00' ], 1 ).execute.map(&:id)).to eq([ 1 ])
    expect(searcher(scope, [ '0000ff' ], 1 ).execute.map(&:id)).to eq([ 2 ])

    expect(searcher(scope, [ 'ff0000', '00ff00' ], 2 ).execute.map(&:id)).to eq([ 3, 1 ])
    expect(searcher(scope, [ '0000ff' ], 3 ).execute.map(&:id)).to eq([ 2, 1, 3 ])
  end

  def searcher(collection, colors, count)
    Incollage::SearchClippingsForCollage.new(collection, colors, count)
  end

end
