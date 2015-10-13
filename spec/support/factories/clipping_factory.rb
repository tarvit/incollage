class ClippingFactory

  class << self

    def get(opts={})
      Incollage::Clipping.new(defaults.merge opts)
    end

    def defaults
      {
          user_id: 1,
          external_id: 1,
          external_created_time: Time.now.to_i,
          collection_id: 1,
          picture_url: 'http://pic.com/pic.png',
          histogram: Incollage::Histogram.new(1 => '00ff00')
      }
    end

  end

end
