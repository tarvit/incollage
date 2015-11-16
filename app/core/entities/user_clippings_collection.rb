class Incollage::UserClippingsCollection < Incollage::Entity::Base

  attribute :user_id, Integer
  attribute :collection_id, Integer
  attribute :linked_account_id, Integer

end
