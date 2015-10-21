module Incollage
  class FindClippingsPage
    attr_reader :finder

    def initialize(attrs)
      @attrs = attrs
      @page_number, @per_page = attrs[:page_number], attrs[:per_page]
      @finder = ClippingsFinder.new(collection)
    end

    def execute
      finder.find_page(@page_number, @per_page)
    end

    protected

    def collection
      UserClippingsCollection.new(
          user_id: @attrs[:user_id],
          collection_id: @attrs[:collection_id],
          linked_account_id: @attrs[:linked_account_id]
      )
    end

  end
end
