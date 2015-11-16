class Incollage::Histogram < Incollage::ValueObject::Base

  attribute :scores, Hash

  def initialize(scores)
    super(scores: scores)
  end

end
