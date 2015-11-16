class Incollage::User < Incollage::Entity::Base

  attribute :full_name, String
  attribute :username, String
  attribute :password_digest, String

  include ActiveModel::SecurePassword
  has_secure_password

  validates_presence_of :username
end
