module Incollage
  class FindClippings

    def initialize(clipping_collection)
      @clipping_collection = clipping_collection
    end

    def find
      Repository.for_clipping.find(search_attrs)
    end

    def find_last
      Repository.for_clipping.find_last(search_attrs)
    end

    def find_all
      Repository.for_clipping.find_all(search_attrs)
    end

    def find_page(page_number, per_page)
      Repository.for_clipping.find_all_on_page(search_attrs, page_number, per_page)
    end

    protected

    def search_attrs
      { user_id: @clipping_collection.user_id, collection_id: @clipping_collection.id }
    end

  end
end
