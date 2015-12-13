require 'rails_helper'

describe CollageOptionsPresenter do
  let(:presenter) do
    described_class.new(TestFactories::StatsFactory.get)
  end

  it 'should present options' do
    expect(presenter._custom_hash).to be
  end
end
