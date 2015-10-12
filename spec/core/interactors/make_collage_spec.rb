require 'spec_helper'

describe Incollage::MakeCollage do

  before :each do
    @files = [ 1, 2, 3, 4 ].map{|i| picture_file("flowers/#{i}.jpg") }
  end

  it 'should add a clipping' do
    collage_file = Incollage::MakeCollage.new(@files).execute
    expect(collage_file).to be_a(File)
  end

end
