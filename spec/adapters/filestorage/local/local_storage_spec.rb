require 'spec_helper'

describe LocalFileStorage do

  before :each do
    @dir = app_root.join('tmp/testfs').to_s
  end

  context 'Initialization' do
    it 'should be prepared correctly' do
      current_dir = [ @dir, SecureRandom.hex ].join

      expect(Dir.exists?(current_dir)).to be_falsey
      LocalFileStorage.new(current_dir)

      expect(Dir.exists?(current_dir)).to be_truthy
    end
  end

  context 'Methods' do

    before :each do
      file = picture_file('flowers/1.jpg')
      Incollage::Service.register(:downloader, TestSupport::FakeHttpDownloader.new({
        'http://fake.url' => file,
        'http://fake/1/url' => file,
        'http://fake/2/url' => file,
      }))
      @fs = LocalFileStorage.new(@dir)
    end

    after :each do
      @fs.clean
    end

    it 'should save files' do
      file_path = @fs.save_file('http://fake.url', 'abstract_path')
      expect(file_path).to include(@dir)
      expect(file_path).to include('abstract_path')
      expect(File.exist?(file_path)).to be_truthy
    end

    it 'should save files to a safe directory' do
      dir = @fs.safe_dir
      f1 = @fs.save_file('http://fake/1/url', "#{ dir }/#{ @fs.safe_path }")
      f2 = @fs.save_file('http://fake/2/url', "#{ dir }/#{ @fs.safe_path }")
      [ f1, f2 ].each do |f|
        expect(f).to include(@dir)
        expect(f).to include(dir)
        expect(File.exist?(f)).to be_truthy
      end
    end
  end
end
