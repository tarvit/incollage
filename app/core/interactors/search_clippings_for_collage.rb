module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      Repository.for_clipping.find_for_collage(@options, @palette_colors, @count)
    end
  end
end
