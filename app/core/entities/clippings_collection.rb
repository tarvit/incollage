class Incollage::ClippingsCollection < Incollage::Entity::Base

  attr_accessor :user_id, :id, :clippings

  def initialize(user_id, id)
    @user_id, @id, @clippings = user_id, id
  end

end
