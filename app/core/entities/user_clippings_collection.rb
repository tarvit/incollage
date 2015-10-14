class Incollage::UserClippingsCollection < Incollage::Entity::Base

  attr_accessor :user_id, :collection_id

  def initialize(user_id, collection_id)
    @user_id, @collection_id = user_id, collection_id
  end

end
