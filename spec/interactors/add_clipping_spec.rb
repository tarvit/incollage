require 'spec_helper'

describe Incollage::ClippingAdder do

  it 'should add a clipping' do
    attrs = { user_id: 0, file_path: 'some_path', histogram_scores: { 1 => '00ff00' } }

    expect(->{
      Incollage::ClippingAdder.new( attrs ).add
    }).to change{
      Incollage::Repository.for_clipping.count
    }.by(1)
  end



end
