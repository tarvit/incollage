class SimpleHttpDownloader

  def download(url, filename)
    uri = URI.parse(url.gsub('https://', 'http://'))
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      file = Tempfile.new(filename, Dir.tmpdir, 'wb+')
      file.binmode
      file.write(resp.body)
      file.flush
      file
    end
  end

end