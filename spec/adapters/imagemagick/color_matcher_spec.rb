require 'spec_helper'

describe Imagemagick::PaletteColorMatcher do

  before :each do
    @histogram = { 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff' }

    @matcher = Imagemagick::PaletteColorMatcher.new
    @delta = 0.2
  end

  it 'should find scores' do
    expect(@matcher.score(@histogram, ['00ff00'])).to be_within(@delta).of(0.45)
    expect(@matcher.score(@histogram, ['0000ff'])).to be_within(@delta).of(0.05)
    expect(@matcher.score(@histogram, ['ff0000'])).to be_within(@delta).of(0.5)
  end

end
