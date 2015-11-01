class ClippingActiveRecord::ToRecord

  attr_reader :entity, :record

  def initialize(entity, record)
    @entity = entity
    @record = record
  end

  def construct
    fill_clipping_fields
    fill_picture_fields if entity.picture
    fill_histogram_field if (entity.picture && entity.picture.histogram)
    record
  end

  protected

  def fill_clipping_fields
    record.user_id = entity.user_id
    record.collection_id = entity.collection_id
    record.linked_account_id = entity.linked_account_id
  end

  def fill_picture_fields
    record.picture_url = entity.picture.url
    record.external_id = entity.picture.external_id
    record.source_id = entity.picture.source_id
    record.external_created_time = entity.picture.external_created_time
  end

  def fill_histogram_field
    record.histogram = Oj.dump(entity.picture.histogram)
  end

end

=begin
SIMPLE_FIELDS = [ :user_id, :external_id, :external_created_time, :collection_id, :linked_account_id, :picture_url ]
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
=end