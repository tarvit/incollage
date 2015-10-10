class Incollage::Clipping < Incollage::Entity::Base

  DEFAULT_ATTRIBUTES = {
      collection_id: 0
  }

  attr_accessor :user_id, :collection_id, :external_id, :external_created_time, :file_path, :histogram
  validates_presence_of :user_id, :external_id, :external_created_time, :collection_id, :file_path, :histogram

  def initialize(attrs)
    super DEFAULT_ATTRIBUTES.merge(attrs)
  end

end
