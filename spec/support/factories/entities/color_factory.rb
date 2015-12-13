module TestFactories
  class ColorFactory < BaseFactory

    class << self
      def entity
        Incollage::Color
      end

      def defaults
        {
            hex_value: '00ff00',
            name: 'Green',
        }
      end
    end
  end
end
