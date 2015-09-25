class Incollage::Repository::InMemoryBase < Incollage::Repository::Base

  def initialize
    @records = {}
    @next_id = 1
  end

  def save(entity)
    entity.id = @next_id
    @records[@next_id] = entity
    @next_id += 1
    entity
  end

  def all
    records
  end

  def first
    first_key = records.keys.sort.first
    records[first_key]
  end

  def last
    last_key = records.keys.sort.last
    records[last_key]
  end

  private

  attr_reader :records
end
