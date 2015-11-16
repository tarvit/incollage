module Incollage
  class ExternalAccount < Incollage::Entity::Base

    attribute :name, Symbol
    attribute :label, String
    attribute :collections, Array[Object]
    attribute :connector, Object

    validates :name, :label, :connector, presence: true
    validate :check_connector

    protected

    def check_connector
      unless self.connector.kind_of?(Incollage::ExternalAccountConnector::Base)
        errors.add(:connector, 'Connector must be a subclass of Incollage::ExternalAccount::Connector::Base')
      end
    end
  end
end
