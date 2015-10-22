class Incollage::ExternalClippingsCollection < Incollage::Entity::Base

  attr_accessor :id, :name, :label, :source
  validates :name, :label, :source, presence: true

end
