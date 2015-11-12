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
    record.external_id = entity.external_id
  end

  def fill_picture_fields
    record.picture_url = entity.picture.url
    record.external_id = entity.picture.external_id
    record.external_created_time = entity.picture.external_created_time
  end

  def fill_histogram_field
    record.histogram = Oj.dump(entity.picture.histogram)
  end

end
