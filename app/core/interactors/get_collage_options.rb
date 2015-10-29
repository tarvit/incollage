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
      {
          collections: collections
      }
    end

    def collage_options
      { layout: :row, count: [ 3, 4, 5, 6 ] }
    end

    def collections
      Holder.for_clippings_collections.added_collections.map do |c|
        { id: c.id, name: c.name }
      end
    end

    def color_options
      [
          { name: :White,	hex: 'FFFFFF' },
          { name: :Yellow,hex:'FFFF00' },
          { name: :Fuchsia,	hex: 'FF00FF' },
          { name: :Red,	hex: 'FF0000' },
          { name: :Silver, hex: 'C0C0C0' },
          { name: :Gray, hex: '808080' },
          { name: :Olive,	hex: '808000' },
          { name: :Purple, hex:'800080' },
          { name: :Maroon, hex:'800000' },
          { name: :Aqua, hex: '00FFFF' },
          { name: :Lime, hex: '00FF00' },
          { name: :Teal, hex: '008080' },
          { name: :Green,	hex: '008000' },
          { name: :Blue, hex: '0000FF' },
          { name: :Navy, hex: '000080' },
          { name: :Black, hex: '000000' },
      ]
    end

  end
end

