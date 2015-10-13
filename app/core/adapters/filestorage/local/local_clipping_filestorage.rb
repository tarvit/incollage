class LocalCollageFilestorage
  attr_reader :storage_directory

  def initialize(storage_directory)
    @storage_directory = storage_directory
    prepare
  end

  def save_clipping(url, external_id)
    Incollage::Gateway.for_downloader.download(url, safe_clipping_path(external_id))
  end

  def safe_collage_path(user_id)
    ([ collages_directory_path, "#{ user_id }_#{ new_rand_id }" ] * ?/)+'.png'
  end

  def clean
    FileUtils.rm_rf storage_directory
  end

  protected

  def clippings_directory_path
    [ storage_directory, 'clippings' ] * ?/
  end

  def collages_directory_path
    [ storage_directory, 'collages' ] * ?/
  end

  def clipping_filename(external_id)
    "media_clipping_#{ external_id }"
  end

  def safe_clipping_path(external_id)
    [ clippings_directory_path, "#{ new_rand_id(external_id) }" ] * ?/
  end

  def prepare
    [ clippings_directory_path, collages_directory_path ].each do |dir|
      FileUtils.mkdir_p dir
    end
  end

  def new_rand_id(external_id=nil)
    [timestamp, external_id, SecureRandom.hex].compact * ?_
  end

  def timestamp
    Time.now.to_i
  end
end
