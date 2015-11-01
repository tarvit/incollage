class LocalFileStorage
  attr_reader :storage_directory

  def initialize(storage_directory)
    @storage_directory = storage_directory
    prepare storage_directory
  end

  def save_file(url, path=nil)
    saving_path = full_path(path || safe_path)
    Incollage::Service.for_downloader.download(url, saving_path)
    saving_path
  end

  def safe_dir
    dir = [ 'dir', new_rand_id ]* ?_
    prepare(full_path(dir))
    dir
  end

  def safe_path(id = nil)
    [ new_rand_id, id ].compact * ?_
  end

  def clean
    FileUtils.rm_rf storage_directory
  end

  def full_path(path)
    [ storage_directory, path ] *?/
  end

  protected

  def prepare(dir)
    FileUtils.mkdir_p dir
  end

  def new_rand_id
    [ timestamp, SecureRandom.hex ].compact * ?_
  end

  def timestamp
    Time.now.to_i
  end
end
