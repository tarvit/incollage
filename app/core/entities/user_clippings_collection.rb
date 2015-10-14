class Incollage::UserClippingsCollection < Incollage::Entity::Base

  attr_accessor :user_id, :id

  def initialize(user_id, id)
    @user_id, @id = user_id, id
  end

end
