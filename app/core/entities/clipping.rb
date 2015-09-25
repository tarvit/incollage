class Incollage::Clipping < Incollage::Entity::Base

  DEFAULT_ATTRIBUTES = {
      collection_id: 0
  }

  attr_accessor :user_id, :collection_id, :file_path, :histogram_scores
  validates_presence_of :user_id, :collection_id, :file_path, :histogram_scores

  def initialize(attrs)
    super DEFAULT_ATTRIBUTES.merge(attrs)
  end

end
