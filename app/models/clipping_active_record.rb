class ClippingActiveRecord < ActiveRecord::Base
  self.table_name = 'clippings'

  class Repository
    def save(clipping)
      from_entity(clipping).save
    end

    def delete_all
      active_record.delete_all
    end

    def count
      active_record.count
    end

    def find_all(options)
      to_entities query(options)
    end

    def all
      find_all({})
    end

    def find_last(options)
      to_entity query(options).last
    end

    def find(options)
      to_entity query(options).first
    end

    def find_all_on_page(options, page_number, per_page)
      to_entities query(options).page(page_number+1).per(per_page)
    end

    def first
      find({})
    end

    def last
      find_last({})
    end

    def delete(clipping)
      from_entity(clipping).destroy
    end

    protected

    def to_entities(records)
      records.map do |record|
        to_entity(record)
      end
    end

    def to_entity(record)
      record ? Incollage::Clipping.new(record.entity_attributes) : nil
    end

    def from_entity(entity)
      record = base_record(entity.id)
      record.user_id = entity.user_id
      record.collection_id = entity.collection_id
      record.file_path = entity.file_path
      record.histogram = entity.histogram.to_json
      record
    end

    def query(options)
      active_record.where(options)
    end

    def active_record
      ClippingActiveRecord
    end

    def base_record(id)
      existing_record = active_record.where(id: id).take
      existing_record ? existing_record : active_record.new(id: id)
    end
  end

  def entity_attributes
    scores = histogram.nil? ? {} : Hash[(JSON.parse(histogram)['scores']).map{|(k,v)| [k.to_f, v] }]
    entity_histogram = Incollage::Histogram.new(scores)
    { id: id, user_id: user_id, file_path: file_path, histogram: entity_histogram }
  end

end
