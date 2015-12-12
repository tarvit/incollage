require 'spec_helper'

describe Imagemagick::PaletteColorMatcher do

  shared_examples 'Scores calculation' do |color, value|
    let(:histogram) do
      { 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff' }
    end

    let(:matcher) { described_class.new }
    let(:delta) { 0.2 }

    subject do
      matcher.score(histogram, [color])
    end

    it { is_expected.to be_within(delta).of(value) }
  end

  context 'green' do
    include_examples 'Scores calculation', '00ff00', 0.45
  end

  context 'blue' do
    include_examples 'Scores calculation', '0000ff', 0.05
  end

  context 'red' do
    include_examples 'Scores calculation', 'ff0000', 0.5
  end
end
