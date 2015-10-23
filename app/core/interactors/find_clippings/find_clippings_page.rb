module Incollage
  class FindClippingsPage
    attr_reader :finder

    def initialize(attrs)
      @attrs = attrs
      @page_number, @per_page = attrs[:page_number], attrs[:per_page]
      @finder = ClippingsFinder.new(search_attrs)
    end

    def execute
      finder.find_page(@page_number, @per_page)
    end

    protected

    def search_attrs
      res = @attrs.clone
      res.delete :page_number
      res.delete :per_page
      res
    end

  end
end
