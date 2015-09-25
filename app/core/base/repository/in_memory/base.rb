class Incollage::Repository::InMemoryBase < Incollage::Repository::Base

  def initialize
    init_values
  end

  def save(entity)
    unless entity.id
      entity.id = @next_id
      @next_id += 1
    end
    unless entity.valid?
      raise Incollage::Repository::EntityIsInvalidError.new(entity.error_messages)
    end
    @records[ entity.id ] = entity
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
    all.select do |record|
      options.all? do |(attr, value)|
        record.send(attr) == value
      end
    end
  end

  def find(options)
    find_all(options).first
  end

  def find_last(options)
    find_all(options).last
  end

  def find_all_on_page(options, page_number, per_page)
    result = find_all(options)
    start_index = per_page * page_number
    end_index = [ (start_index + per_page - 1), result.length ].min
    result[start_index..end_index]
  end

  private

  attr_reader :records

  def init_values
    @records = {}
    @next_id = 1
  end

end
