class HttpClientDownloader
  require 'httpclient'

  DEFAULTS = {
    after_timeout_tries: 1,
    connect_timeout: 60,
    receive_timeout: 60
  }

  def initialize(opts = {})
    @options = opts.merge(DEFAULTS)
  end

  def download(url, fullpath)
    options[:after_timeout_tries].times do
      begin
        return process_download(url, fullpath)
      rescue TimeoutError
        next
      end
    end
  end

  private
  attr_reader :options

  def process_download(url, fullpath)
    file = File.new(fullpath, 'wb')
    file.write(url_content(url))
    file.close
  end

  def url_content(url)
    client.get_content(url.gsub('https://', 'http://'))
  end

  def client
    hc = HTTPClient.new
    hc.connect_timeout = options[:connect_timeout]
    hc.receive_timeout = options[:receive_timeout]
    hc
  end
end
