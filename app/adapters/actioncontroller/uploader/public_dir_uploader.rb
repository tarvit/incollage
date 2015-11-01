class PublicDirUploader < LocalFileStorage

  attr_reader :namespace

  def  initialize(namespace)
    @namespace = namespace
    prepare storage_directory
  end

  def upload(file_path)
    path = next_safe_path(file_path)
    FileUtils.cp file_path, path
    url(path)
  end

  protected

  def public_directory
    Rails.root.join('public')
  end

  def storage_directory
    public_directory.join(@namespace)
  end

  def next_safe_path(file_path)
    full_path(safe_path + file_path.extname)
  end

  def url(path)
    path.to_s.gsub(public_directory.to_s, '')
  end

end
