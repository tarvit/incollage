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
        linked_account_id: record.linked_account_id,
        picture: Incollage::Picture.new(picture_fields)
    }
  end

  def picture_fields
    {
        url: record.picture_url,
        external_id: record.external_id,
        external_created_time: record.external_created_time,
        histogram: Incollage::Histogram.new(histogram_field)
    }
  end

  def histogram_field
    Oj.load(record.histogram)
  end

end
