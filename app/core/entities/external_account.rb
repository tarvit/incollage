class Incollage::ExternalAccount < Incollage::Entity::Base

  attr_accessor :name, :label, :connector, :collections
  validates :name, :label, :connector, presence: true

end
