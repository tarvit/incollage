module Incollage
  class GetCollageOptions

    def execute
      {
          search: search_options,
          colors: color_options,
          collage: collage_options,
      }
    end

    protected

    def search_options
      { collections: collections }
    end

    def collage_options
      { layout: :row, count: [ 3, 4, 5, 6 ] }
    end

    def collections
      Holder.for_clippings_collections.added_collections.map do |c|
        { id: c.id, label: c.label }
      end
    end

    def color_options
      Holder.for_standard_colors.added_colors.map do |color|
        { name: color.name, hex: color.hex_value }
      end
    end
  end
end

