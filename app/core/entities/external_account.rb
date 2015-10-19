class Incollage::ExternalAccount < Incollage::Entity::Base

  attr_accessor :name, :collections

  def initialize(id, name, collections)
    @id, @name, @collections = id, name, collections
  end

end
