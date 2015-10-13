module TestSupport
  class FakeHttpDownloader

    def download(url, fullpath)
      fakes[url] || File.new(fullpath, 'w')
    end

    # used for testing
    def set_fake_url(url, file)
      fakes[url] = file
    end

    def fakes
      @fakes ||= {}
    end

  end
end

