module TestFactories
  class StandardColorsHolderFactory

    def self.get(colors = [ name: :red, hex_value: 'ff0000' ])
      holder = Incollage::StandardColorsHolder.new
      colors.each {|c| holder.add c }
      holder
    end
  end
end
