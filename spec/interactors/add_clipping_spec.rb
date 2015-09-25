require 'spec_helper'

describe Incollage::ClippingAdder do

  it 'should add a clipping' do
    expect(->{
      Incollage::ClippingAdder.new({  }).add
    }).to change{
      Incollage::Repository.for_clipping.count
    }.by(1)
  end



end
