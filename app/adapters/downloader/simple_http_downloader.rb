class SimpleHttpDownloader
  require 'open-uri'

  def download(url, fullpath)
    uri = URI.parse(url.gsub('https://', 'http://'))
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      file = File.open(fullpath, 'w')
      file.binmode
      file.write(resp.body)
      file.flush
      file
    end
  end

end
