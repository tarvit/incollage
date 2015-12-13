module Incollage
  class SearchClippingsForCollage

    def initialize(options, palette_colors, count)
      @options, @palette_colors, @count = options, palette_colors, count
    end

    def execute
      Repository.for_clipping.find_for_collage(@palette_colors, @options, @count)
    end
  end
end
