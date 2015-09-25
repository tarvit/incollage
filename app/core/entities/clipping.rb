class Incollage::Clipping < Incollage::Entity::Base

  DEFAULT_ATTRIBUTES = {
      library_id: 0
  }

  attr_accessor :user_id, :library_id, :file_path, :histogram_scores
  validates_presence_of :user_id, :library_id, :file_path, :histogram_scores

  def initialize(attrs)
    DEFAULT_ATTRIBUTES.merge(attrs)
  end

end
