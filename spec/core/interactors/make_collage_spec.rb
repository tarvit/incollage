require 'spec_helper'

describe Incollage::MakeCollage do

  before :each do
    @files = [ 1, 2, 3, 4 ].map{|i| picture_file("flowers/#{i}.jpg") }

    folder = '/tmp/test/images'
    FileUtils.mkdir_p folder
    @path = app_root.join("#{folder}/res.png")
  end

  it 'should add a clipping' do
    collage_file = Incollage::MakeCollage.new(@files, @path).execute
    expect(collage_file).to be
  end

end
