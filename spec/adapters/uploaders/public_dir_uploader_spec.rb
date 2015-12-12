require 'rails_helper'

describe PublicDirUploader do
  let(:file) { picture_file('flowers/1.jpg') }
  let(:uploader) { described_class.new("fs/test/#{rand(100)}") }

  after :each do
    uploader.clean
  end

  subject { uploader.upload(file) }

  it { is_expected.to start_with('/fs/test/') }
  it { is_expected.to end_with('.jpg') }
end
