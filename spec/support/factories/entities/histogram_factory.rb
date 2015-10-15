module TestFactories
  class HistogramFactory < BaseFactory

    class << self

      def entity
        Incollage::Histogram
      end

      def defaults
        { 1 => '00ff00' }
      end

    end

  end
end
