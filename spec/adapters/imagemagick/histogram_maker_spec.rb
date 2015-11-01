require 'spec_helper'

describe Imagemagick::HistogramMaker do

  before :each do
    @url = 'http://flowers.com/flower.jpg'
    @file = picture_file('flowers/1.jpg')

    @fs = TestSupport::FakeFileStorage.new(@url => @file)
    Incollage::Service.register(:local_filestorage, @fs)
  end

  it 'should make histograms' do
    data = Imagemagick::HistogramMaker.new.make(@url)
    expect(data).to be_a(Hash)
    expect(data.values).to include('000000')
    expect(data.values).to include('ffffff')
  end

end
