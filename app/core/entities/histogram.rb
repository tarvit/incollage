class Incollage::Histogram < Incollage::Entity::Base

  attr_accessor :scores

  def initialize(scores)
    @scores = scores
  end

end
