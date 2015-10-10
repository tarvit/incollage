class ClippingActiveRecord < ActiveRecord::Base
  self.table_name = 'clippings'

  require 'base_repository'
  class Repository < ActiveRecordBaseRepository

    protected

    def active_record
      ClippingActiveRecord
    end

    def entity_class
      Incollage::Clipping
    end

    SIMPLE_FIELDS = [ :user_id, :external_id, :collection_id, :file_path ]
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
      scores = record.histogram.nil? ? {} : Hash[(JSON.parse(record.histogram)['scores']).map{|(k,v)| [k.to_f, v] }]
      Incollage::Histogram.new(scores)
    end

  end
end
