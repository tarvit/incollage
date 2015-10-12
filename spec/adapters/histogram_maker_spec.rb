require 'spec_helper'

describe Imagemagick::HistogramMaker do

  it 'should make histograms' do
    data = Imagemagick::HistogramMaker.new(picture_file('flowers/1.jpg')).make
    scores = {
        0.3718820224719101=>'ffffff',
        0.17784644194756555=>'000000',
        0.17411048689138578=>'ff0000',
        0.14664794007490636=>'00ff00',
        0.1171067415730337=>'ffff00',
        0.012406367041198503=>'ff00ff'
    }
    expect(data).to eq(scores)
  end

end
