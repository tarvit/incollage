require 'spec_helper'

describe Incollage::MakeCollage do
  let(:downloader) { TestSupport::FakeHttpDownloader.new }
  let(:maker) { TestSupport::FakeCollageMaker.new }

  let(:clippings) do
    [ 1, 2, 3, 4 ].map do |i|
      name = "flowers/#{i}.jpg"
      file = picture_file(name)
      url = "http://fake.url/#{name}"
      downloader.add_fake(url, file)

      picture = TestFactories::PictureFactory.get(url: url)
      TestFactories::ClippingFactory.get(id: i, picture: picture)
    end
  end

  before do |example|
    example.with_downloader(downloader)
    example.with_collage_maker(maker)
  end

  subject { described_class.new(clippings, 1).execute }

  it { is_expected.to be }
end
