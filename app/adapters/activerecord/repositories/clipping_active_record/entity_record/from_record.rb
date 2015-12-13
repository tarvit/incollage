class ClippingActiveRecord::FromRecord

  attr_reader :record

  def initialize(record)
    @record = record
  end

  def attributes
    clipping_fields
  end

  protected

  def clipping_fields
    {
        id: record.id,
        user_id: record.user_id,
        collection_id: record.collection_id,
        external_id: record.external_id,
        external_created_time: record.external_created_time,
        linked_account_id: record.linked_account_id,
        picture: picture_fields,
    }
  end

  def picture_fields
    {
        url: record.picture_url,
        histogram: histogram_field
    }
  end

  def histogram_field
    Oj.load(record.histogram)
  end

end
