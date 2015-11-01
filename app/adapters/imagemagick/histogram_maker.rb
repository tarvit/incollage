module Imagemagick

  class HistogramMaker
    require 'colorscore'

    DEFAULT_OPTIONS = {
      colors_count: 10, depth: 1
    }
    attr_reader :options

    def initialize(options={})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def make(url)
      histogram = Colorscore::Histogram.new(file(url), colors_count, depth)
      scores = histogram.scores.map do |(score, color_rgb)|
        [ score, color_rgb.hex ]
      end
      Hash[scores]
    end

    protected

    def file(url)
      Incollage::Service.for_local_filestorage.save_file(url).to_s
    end

    def colors_count
      options[:colors_count]
    end

    def depth
      options[:depth]
    end

  end
end
