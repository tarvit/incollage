class ActiveRecordBaseRepository

  def save(entity)
    entity.validate!
    record = from_entity(entity)
    record.save!
    entity.id = record.id
    entity
  rescue ActiveRecord::RecordInvalid => ex
    raise Incollage::Validateable::BusinessObjectIsInvalidError.new(ex.message)
  end

  def delete_all
    active_record.delete_all
  end

  def count(opts={})
    query(opts).count
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

  def delete(entity)
    from_entity(entity).destroy
  end

  def exists?(opts)
    query(opts).count > 0
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
    record ? entity_class.new(entity_attributes(record)) : nil
  end

  def entity_class
    raise NotImplementedError
  end

  def from_entity(_entity)
    raise NotImplementedError
  end

  def entity_attributes(_record)
    raise NotImplementedError
  end

  def active_record
    raise NotImplementedError
  end

end
