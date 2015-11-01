class Incollage::Clipping < Incollage::Entity::Base

  attr_accessor :user_id, :collection_id, :linked_account_id, :picture
  validates_presence_of :user_id, :collection_id, :linked_account_id, :picture

  delegate :external_id, :external_id=, to: :picture
end
