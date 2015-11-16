module Incollage
  class Clipping < Incollage::Entity::Base

    attribute :user_id, Integer
    attribute :collection_id, Integer
    attribute :linked_account_id, Integer
    attribute :external_id, Integer
    attribute :external_created_time, Integer
    attribute :picture, Picture

    validates_presence_of :user_id, :collection_id, :linked_account_id, :external_id, :picture, :external_created_time

    def valid?
      super && picture.valid?
    end

  end
end
