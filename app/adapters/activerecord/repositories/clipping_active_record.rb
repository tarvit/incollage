class ClippingActiveRecord < ActiveRecord::Base
  self.table_name = 'clippings'

  class Repository < ActiveRecordBaseRepository

    def most_recent(opts)
      recent_query(opts).first
    end

    def most_preceding(opts)
      preceding_query(opts).first
    end

    protected

    def preceding_query(opts)
      query(opts).order('external_id asc')
    end

    def recent_query(opts)
      query(opts).order('external_id desc')
    end


    def active_record
      ClippingActiveRecord
    end

    def entity_class
      Incollage::Clipping
    end

    SIMPLE_FIELDS = [ :user_id, :external_id, :external_created_time, :collection_id, :picture_url ]
    def from_entity(entity)
      record = base_record(entity.id)

      SIMPLE_FIELDS.each do |f|
        record.send("#{f}=", entity.send(f))
      end

      record.histogram = entity.histogram.to_json
      record
    end

    def entity_attributes(record)
      simple_fields = SIMPLE_FIELDS.each_with_object({}) do |f, res|
        res[f] = record.send(f)
      end

      { id: record.id, histogram: entity_histogram(record) }.merge(simple_fields)
    end

    private

    def entity_histogram(record)
      scores = record.histogram.nil? ? {} : Hash[(JSON.parse(record.histogram)).map{|(k,v)| [k.to_f, v] }]
      Incollage::Histogram.new(scores)
    end

  end
end
