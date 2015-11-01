require 'rails_helper'

describe PublicDirUploader do

  before :each do
    @file = picture_file('flowers/1.jpg')
    @uploader = PublicDirUploader.new("fs/test/#{rand(100)}")
  end

  after :each do
    @uploader.clean
  end

  it 'should upload files' do
    url = @uploader.upload(@file)

    expect(url).to start_with('/fs/test/')
    expect(url).to end_with('.jpg')
  end

end
