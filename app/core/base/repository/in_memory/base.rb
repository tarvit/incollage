class Incollage::Repository::InMemoryBase < Incollage::Repository::Base

  def initialize
    init_values
  end

  def save(entity)
    entity.id = @next_id
    @records[@next_id] = entity
    @next_id += 1
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

  private

  attr_reader :records

  def init_values
    @records = {}
    @next_id = 1
  end

end
