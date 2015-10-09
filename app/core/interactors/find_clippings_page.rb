module Incollage
  class FindClippingsPage

    def initialize(user_id, collection_id, page_number, per_page)
      @page_number, @per_page = page_number, per_page

      collection = ClippingsCollection.new(user_id: user_id, collection_id: collection_id)
      @finder = ClippingsFinder.new(collection)
    end

    def execute
      @finder.find_page(@page_number, @per_page)
    end

  end
end
