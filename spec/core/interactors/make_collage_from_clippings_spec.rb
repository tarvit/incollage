require 'spec_helper'

describe Incollage::MakeCollageFromClippings do

  before :each do
    @clippings = [ 1, 2, 3, 4 ].map do |i|
      name = "flowers/#{i}.jpg"
      file = File.open(picture_file(name))
      url = "http://fake.url/#{name}"
      Incollage::Gateway.for_downloader.set_fake_url(url, file)
      OpenStruct.new(picture_url: url, id: i)
    end
  end

  it 'should add a clipping' do
    collage_file = Incollage::MakeCollageFromClippings.new(@clippings, 1).execute
    expect(collage_file).to be
  end

end
