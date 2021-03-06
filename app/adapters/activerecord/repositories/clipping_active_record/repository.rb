class ClippingActiveRecord
  class Repository < ActiveRecordBaseRepository

    def find_for_collage(opts, colors, count)
      find_all(opts).sort_by{|cl|
        -Incollage::Service.for_color_matcher.score(cl.picture.histogram.scores, colors)
      }[0...count]
    end

    def most_recent(opts)
      to_entity recent_query(opts).first
    end

    def most_preceding(opts)
      to_entity preceding_query(opts).first
    end

    protected

    def preceding_query(opts)
      query(opts).order('external_created_time asc, external_id asc')
    end

    def recent_query(opts)
      query(opts).order('external_created_time desc, external_id desc')
    end

    def active_record
      ClippingActiveRecord
    end

    def entity_class
      Incollage::Clipping
    end

    def from_entity(entity)
      ToRecord.new(entity, base_record(entity.id)).construct
    end

    def entity_attributes(record)
      FromRecord.new(record).attributes
    end
  end
end
