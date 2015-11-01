module TestFactories
  class HistogramFactory < BaseFactory

    class << self

      def get(opts=nil)
        entity.new(opts || defaults)
      end

      def entity
        Incollage::Histogram
      end

      def defaults
        { 1 => '00ff00' }
      end

    end

  end
end
