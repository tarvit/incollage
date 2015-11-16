class Incollage::LinkedAccount < Incollage::Entity::Base

  attribute :user_id, Integer
  attribute :external_account_id, Integer
  attribute :external_user_id, String
  attribute :external_meta_info, Hash

  validates :user_id, :external_account_id, :external_user_id, presence: true

end
