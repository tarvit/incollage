module TestSupport
  class FakeHttpDownloader
    attr_reader :fakes

    def initialize(fakes = {})
      @fakes = fakes
    end

    def add_fake(url, path)
      @fakes[url] = path
    end

    def download(url, fullpath)
      FileUtils.cp fakes[url], fullpath
    end

  end
end

