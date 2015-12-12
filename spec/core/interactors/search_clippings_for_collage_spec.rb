require 'spec_helper'

describe Incollage::SearchClippingsForCollage do
  let(:scope) do
    {user_id: 1, collection_id: 1}
  end

  before do |example|
    example.with_clipping_repo
    example.with_color_matcher

    [
        { id: 1, picture: picture( 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff') },
        { id: 2, picture: picture( 0.7 => 'ff0000', 0.2 => '00ff00', 0.1 => '0000ff') },
        { id: 3, picture: picture( 0.9 => 'ff0000', 0.1 => '00ff00', 0.0 => '0000ff') },
    ].each do |att|
      attrs = TestFactories::ClippingFactory.defaults.merge(att)
      TestFactories::ClippingFactory.create(attrs)
    end
  end

  shared_examples 'search by color' do |colors, count, ids|
    subject { searcher(scope, colors, count ).execute.map(&:id) }

    def searcher(scope, colors, count)
      described_class.new(scope, colors, count)
    end

    it { is_expected.to eq ids }
  end

  context 'Search red' do
    include_examples 'search by color', %w(ff0000), 1, [3]
  end

  context 'Search green' do
    include_examples 'search by color', %w(00ff00), 1, [1]
  end

  context 'Search blue' do
    include_examples 'search by color', %w(0000ff), 1, [2]
  end

  context 'Search red/green' do
    include_examples 'search by color', %w(ff0000 00ff00), 2, [3, 1]
  end

  context 'Search 3 blue pics' do
    include_examples 'search by color', %w(0000ff), 3, [2, 1, 3]
  end

  def picture(scores)
    TestFactories::PictureFactory.get(
      histogram: TestFactories::HistogramFactory.get(scores)
    )
  end
end
