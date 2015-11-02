module Incollage
  class FindClippingsPage
    attr_reader :page_number, :per_page

    def initialize(attrs)
      @attrs = attrs
      @page_number, @per_page = attrs[:page_number], attrs[:per_page]
    end

    def execute
      Repository.for_clipping.find_all_on_page(search_attrs, page_number, per_page)
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
