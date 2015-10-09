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

    def from_entity(entity)
      record = base_record(entity.id)
      record.user_id = entity.user_id
      record.collection_id = entity.collection_id
      record.file_path = entity.file_path
      record.histogram = entity.histogram.to_json
      record
    end

    def entity_attributes(record)
      { id: record.id, user_id: record.user_id, file_path: record.file_path, histogram: entity_histogram(record) }
    end

    private

    def entity_histogram(record)
      scores = record.histogram.nil? ? {} : Hash[(JSON.parse(record.histogram)['scores']).map{|(k,v)| [k.to_f, v] }]
      Incollage::Histogram.new(scores)
    end

  end


end
