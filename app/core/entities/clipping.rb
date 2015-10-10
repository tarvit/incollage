class Incollage::Clipping < Incollage::Entity::Base

  DEFAULT_ATTRIBUTES = {
      collection_id: 0
  }

  attr_accessor :user_id, :collection_id, :external_id, :file_path, :histogram
  validates_presence_of :user_id, :external_id, :collection_id, :file_path, :histogram

  def initialize(attrs)
    super DEFAULT_ATTRIBUTES.merge(attrs)
  end

end
