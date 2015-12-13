module TestFactories
  class AccessCodesHolderFactory

    def self.get(codes = %w(secret))
      holder = Incollage::AccessCodesHolder.new
      codes.each {|code| holder.add code }
      holder
    end
  end
end
