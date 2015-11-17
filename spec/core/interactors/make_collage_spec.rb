require 'spec_helper'

describe Incollage::MakeCollage do

  before :each do |example|
    @downloader = TestSupport::FakeHttpDownloader.new
    @maker = TestSupport::FakeCollageMaker.new

    example.with_downloader(@downloader)
    example.with_collage_maker(@maker)

    @clippings = [ 1, 2, 3, 4 ].map do |i|
      name = "flowers/#{i}.jpg"
      file = picture_file(name)
      url = "http://fake.url/#{name}"
      @downloader.add_fake(url, file)

      picture = TestFactories::PictureFactory.get(url: url)
      TestFactories::ClippingFactory.get(id: i, picture: picture)
    end
  end

  it 'should add a clipping' do
    collage_url = Incollage::MakeCollage.new(@clippings, 1).execute
    expect(collage_url).to be
  end

end
