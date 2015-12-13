require 'spec_helper'

describe Imagemagick::CollageMaker do
  let(:fakes) do
    {
        'http://fake/1/.url' => picture_file('flowers/1.jpg'),
        'http://fake/2/url' => picture_file('flowers/2.jpg'),
        'http://fake/3/url' => picture_file('flowers/3.jpg'),
    }
  end

  let(:downloader) { TestSupport::FakeHttpDownloader.new(fakes) }
  let(:collage) { described_class.new }

  before do |example|
    example.with_local_filestorage
    example.with_uploader
    Incollage::Service.register(:downloader, downloader)
  end

  subject { collage.make(fakes.keys) }

  it 'should make histograms' do
    expect(collage).to be
  end

end
