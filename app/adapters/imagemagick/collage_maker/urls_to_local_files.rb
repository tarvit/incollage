module Imagemagick
  class UrlsToLocalFiles
    attr_reader :urls, :dir

    def initialize(urls)
      @urls = urls
      @dir = Incollage::Service.for_local_filestorage.safe_dir
    end

    def files
      @files ||= download_files
    end

    def output_path
      @output_path ||= (Incollage::Service.for_local_filestorage.full_path(next_safe_path)+'.png')
    end

    protected

    def download_files
      urls.map do |url|
        Incollage::Service.for_local_filestorage.save_file(url, next_safe_path)
      end
    end

    def next_safe_path
      [ dir, Incollage::Service.for_local_filestorage.safe_path ] * ?/
    end
  end
end
