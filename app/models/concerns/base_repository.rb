class ActiveRecordBaseRepository
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

  def query(options)
    active_record.where(options)
  end

  def base_record(id)
    existing_record = active_record.where(id: id).take
    existing_record ? existing_record : active_record.new(id: id)
  end

  def to_entities(records)
    records.map do |record|
      to_entity(record)
    end
  end

  def to_entity(record)
    raise NotImplementedError
  end

  def from_entity(entity)
    raise NotImplementedError
  end

  def entity_attributes(record)
    raise NotImplementedError
  end

  def active_record
    raise NotImplementedError
  end

end