module Incollage
  class ClippingsFinder
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def find
      Repository.for_clipping.find(options)
    end

    def find_last
      Repository.for_clipping.find_last(options)
    end

    def find_all
      Repository.for_clipping.find_all(options)
    end

    def find_page(page_number, per_page)
      Repository.for_clipping.find_all_on_page(options, page_number, per_page)
    end

  end
end
