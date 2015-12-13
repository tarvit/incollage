module Incollage
  class StandardColorsHolder  < ObjectsHolder::NamedEntityBase

    def get(name)
      get_by_name(name)
    end

    def added_colors
      added
    end

    def has_value?(hex_value)
      added.map(&:hex_value).include? hex_value
    end

    protected

    def add_to_content(object)
      raise ArgumentError.new(error_message(object)) if get(object.name)
      content[object.name] = object
    end

    def entity_klass
      Color
    end

    def error_message(object)
      "Color with Name #{object.name} is occupied in the Holder #{self.class.name} already!"
    end
  end
end
