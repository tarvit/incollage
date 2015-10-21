class Incollage::UserClippingsCollection < Incollage::Entity::Base

  attr_accessor :user_id, :collection_id, :linked_account_id

  def initialize1(user_id, collection_id)
    @user_id, @collection_id = user_id, collection_id
  end

end
