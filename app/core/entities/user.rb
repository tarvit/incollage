class Incollage::User < Incollage::Entity::Base

  attr_accessor :full_name, :username

  include ActiveModel::SecurePassword
  attr_accessor :password_digest
  has_secure_password

  validates_presence_of :username
end
