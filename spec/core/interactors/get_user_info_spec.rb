require 'spec_helper'

describe Incollage::AddClipping do

  it 'should add a clipping' do
    expect(->{
      Incollage::AddClipping.new( TestFactories::ClippingFactory.defaults ).execute
    }).to change{
      Incollage::Repository.for_clipping.count
    }.by(1)
  end

end
