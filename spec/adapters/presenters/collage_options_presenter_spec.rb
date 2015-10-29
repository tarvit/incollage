require 'rails_helper'

describe CollageOptionsPresenter do

  before :each do
    @stats = TestFactories::StatsFactory.get
    @presenter = CollageOptionsPresenter.new(@stats)
  end

  it 'should present options' do
    expect(@presenter._custom_hash).to be
  end

end
