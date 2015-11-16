class Incollage::ExternalClippingsCollection < Incollage::Entity::Base

  attribute :id, Integer
  attribute :name, Symbol
  attribute :label, String
  attribute :source, Object

  validates :name, :label, :source, presence: true
end
