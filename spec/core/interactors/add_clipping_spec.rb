require 'spec_helper'

describe Incollage::AddClipping do

  before :each do |example|
    example.with_clipping_repo
  end

  it 'should add a clipping' do
    expect(->{
      Incollage::AddClipping.new( TestFactories::ClippingFactory.defaults ).execute
    }).to change{
      Incollage::Repository.for_clipping.count
    }.by(1)
  end

end
