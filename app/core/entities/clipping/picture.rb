class Incollage::Picture < Incollage::Entity::Base

  attr_accessor :url, :histogram, :external_id, :source_id, :external_created_time
  validates_presence_of  :url, :histogram, :external_id, :source_id, :external_created_time

end
