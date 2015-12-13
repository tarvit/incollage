class PopulateIndex < ActiveRecord::Migration
  def change
    repository = ClippingActiveRecord::IndexedColorRepository.new
    ClippingActiveRecord.where(color_1: 0).find_each(batch_size: 250) do |record|
      entity = repository.send(:to_entity, record)
      repository.send(:populate_color_index, entity, record)
      record.save
    end
  end
end
