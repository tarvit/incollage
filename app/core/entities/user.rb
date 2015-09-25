class Incollage::User < Incollage::Entity::Base

  attr_accessor :full_name, :username
  validates_presence_of :username
end
