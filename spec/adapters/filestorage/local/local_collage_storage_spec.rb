require 'spec_helper'

describe LocalCollageFilestorage do

  before :each do
    @dir = '/tmp/testfs'
  end

  context 'Initialization' do
    it 'should be prepared correctly' do
      current_dir = [ @dir, SecureRandom.hex ].join

      expect(Dir.exists?(current_dir)).to be_falsey
      LocalCollageFilestorage.new(current_dir)

      expect(Dir.exists?(current_dir)).to be_truthy
    end

  end

  context 'Methods' do

    before :each do
      @fs = LocalCollageFilestorage.new(@dir)
    end

    it 'should save clippings' do
      file = @fs.save_clipping('http://fake.url', 'abstract_path')
      expect(file.path).to include(@dir)
      expect(file.path).to include('abstract_path')
    end

    it 'should get path for a collage' do
      path = @fs.safe_collage_path('888')
      expect(path).to include(@dir)
      expect(path).to include('888')
    end

  end

end
