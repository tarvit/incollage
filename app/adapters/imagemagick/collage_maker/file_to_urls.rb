module Imagemagick
  class FileToUrl
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def url
      @url ||= Incollage::Service.for_uploader.upload(@file_path)
    end

  end
end
