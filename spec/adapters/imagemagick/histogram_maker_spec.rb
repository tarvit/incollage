require 'spec_helper'

describe Imagemagick::HistogramMaker do
  let(:url) { 'http://flowers.com/flower.jpg' }
  let(:file) { picture_file('flowers/1.jpg') }
  let(:fs) { TestSupport::FakeFileStorage.new(url => file) }

  before do
    Incollage::Service.register(:local_filestorage, fs)
  end

  subject { described_class.new.make(url) }

  it { is_expected.to be_a(Hash) }

  context 'values' do
    subject  { super().values }

    it { is_expected.to include('000000') }
    it { is_expected.to include('ffffff') }
  end
end
