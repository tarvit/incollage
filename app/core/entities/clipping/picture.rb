class Incollage::Picture < Incollage::Entity::Base

  attr_accessor :url, :histogram, :external_id, :external_created_time
  validates_presence_of  :url, :histogram, :external_id, :external_created_time

  def initialize(attrs)
    super
    self.histogram = attrs[:histogram].is_a?(Hash) ? Incollage::Histogram.new(attrs[:histogram]) : attrs[:histogram]
  end

end
