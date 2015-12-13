module Incollage
  class StandardColorsHolder  < ObjectsHolder::NamedEntityBase

    def added_colors
      added
    end

    def has_value?(hex_value)
      added.map(&:hex_value).include? hex_value
    end

    protected

    def entity_klass
      Color
    end
  end
end
