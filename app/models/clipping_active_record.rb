class ClippingActiveRecord < ActiveRecord::Base
  self.table_name = 'clippings'

  require 'base_repository'
  class Repository < ActiveRecordBaseRepository

    def to_entity(record)
      record ? Incollage::Clipping.new(entity_attributes(record)) : nil
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
      scores = record.histogram.nil? ? {} : Hash[(JSON.parse(record.histogram)['scores']).map{|(k,v)| [k.to_f, v] }]
      entity_histogram = Incollage::Histogram.new(scores)
      { id: record.id, user_id: record.user_id, file_path: record.file_path, histogram: entity_histogram }
    end

    def active_record
      ClippingActiveRecord
    end

  end


end
