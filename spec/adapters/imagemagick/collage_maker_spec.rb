require 'spec_helper'

describe Imagemagick::CollageMaker do

  before :each do
    @fakes = {
        'http://fake/1/.url' => picture_file('flowers/1.jpg'),
        'http://fake/2/url' => picture_file('flowers/2.jpg'),
        'http://fake/3/url' => picture_file('flowers/3.jpg'),
    }
    Incollage::Service.register(:downloader, TestSupport::FakeHttpDownloader.new(@fakes))
  end

  it 'should make histograms' do
    collage = Imagemagick::CollageMaker.new.make(@fakes.keys)
    expect(collage).to be
  end

end
