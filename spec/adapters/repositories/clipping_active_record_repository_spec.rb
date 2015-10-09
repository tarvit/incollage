require 'spec_helper'

describe ClippingActiveRecord::Repository do

  before :each do
    attrs = { id: 1, user_id: 0, file_path: 'some_path', histogram: Incollage::Histogram.new(1 => '00ff00') }
    @clipping = Incollage::Clipping.new attrs
    @repo =  ClippingActiveRecord::Repository.new
  end

  it 'should save clipping records' do
    expect(->{
      @repo.save(@clipping)
    }).to change{ @repo.count }.by(1)

    expect(->{
      @repo.save(@clipping)
    }).to change{ @repo.count }.by(0)
  end

end
