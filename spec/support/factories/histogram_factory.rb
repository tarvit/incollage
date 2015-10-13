module TestFactories
  class HistogramFactory

    class << self

      def get(opts={})
        Incollage::Histogram.new(defaults.merge(opts))
      end

      def defaults
        { 1 => '00ff00' }
      end

    end

  end
end
