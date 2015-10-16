class Incollage::Repository::InMemoryBase

  def initialize
    init_values
  end

  def save(entity)
    populate_id_if_need(entity)
    validate_entity!(entity)
    add_to_memory_storage(entity)

    entity
  end

  def delete(entity)
    remove_from_memory_storage(entity)
    entity
  end

  def all
    records.values
  end

  def first
    first_key = records.keys.sort.first
    records[first_key]
  end

  def last
    last_key = records.keys.sort.last
    records[last_key]
  end

  def delete_all
    init_values
  end

  def find_all(options)
    query(options)
  end

  def find(options)
    query(options).first
  end

  def find_last(options)
    query(options).last
  end

  def find_all_on_page(options, page_number, per_page)
    result = find_all(options)
    start_index = per_page * page_number
    end_index = [ (start_index + per_page - 1), result.length ].min
    result[start_index..end_index]
  end

  def count
    query.count
  end

  def exists?(opts)
    !query(opts).empty?
  end

  protected

  def query(options={})
    all.select do |record|
      options.all? do |(attr, value)|
        record.send(attr) == value
      end
    end
  end

  def validate_entity!(entity)
    entity.check_validity!
  end

  private

  attr_reader :records

  def init_values
    @records = {}
    @next_id = 1
  end

  def populate_id_if_need(entity)
    unless entity.id
      entity.id = @next_id
      @next_id += 1
    end
  end

  def add_to_memory_storage(entity)
    @records[ entity.id ] = entity
  end

  def remove_from_memory_storage(entity)
    @records.delete  entity.id
  end

end
