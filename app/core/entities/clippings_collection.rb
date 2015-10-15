class Incollage::ClippingsCollection < Incollage::Entity::Base

  attr_reader :id, :name, :source

  def initialize(id, name, source)
    @id, @name, @source = id, name, source
  end

end
