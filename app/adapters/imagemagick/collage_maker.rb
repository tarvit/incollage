module Imagemagick

  class CollageMaker

    def make(urls)
      lf = local_files(urls)
      system(command(lf.files, lf.output_path))
      file_to_url(lf.output_path)
    end

    protected

    def local_files(urls)
      UrlsToLocalFiles.new(urls)
    end

    def file_to_url(file)
      FileToUrl.new(file).url
    end

    def command(files, output_path)
      "montage #{files.join(' ')} -size 300x300 -geometry 300x300-10-10 +polaroid -tile x1 -gravity center -background none #{output_path}"
    end
  end
end
