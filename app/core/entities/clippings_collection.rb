class Incollage::ClippingsCollection < Incollage::Entity::Base

  attr_accessor :user_id, :collection_id, :clippings

  def initialize(user_id, id, clippings)
    @user_id, @id, @clippings = user_id, id, clippings
  end

end
