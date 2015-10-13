module TestSupport
  class FakeHttpDownloader

    def download(url, fullpath)
      File.new(fullpath, 'w')
    end

  end
end

