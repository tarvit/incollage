class Incollage::Clipping < Incollage::Entity::Base

  attr_accessor :user_id, :collection_id, :linked_account_id, :external_id, :picture
  validates_presence_of :user_id, :collection_id, :linked_account_id, :external_id, :picture

  def initialize(attrs)
    super
    self.picture = attrs[:picture].is_a?(Hash) ? Incollage::Picture.new(attrs[:picture]) : attrs[:picture]
    self.picture.external_id = self.external_id
  end

  def valid?
    super && picture.valid?
  end

end
