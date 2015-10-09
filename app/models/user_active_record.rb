class UserActiveRecord < ActiveRecord::Base
  self.table_name = 'users'

  require 'base_repository'
  class Repository < ActiveRecordBaseRepository

    def active_record
      UserActiveRecord
    end

    def entity_class
      Incollage::User
    end

    def from_entity(entity)
      record = base_record(entity.id)
      record.username = entity.username
      record.full_name = entity.full_name
      record
    end

    def entity_attributes(record)
      { id: record.id, username: record.username, full_name: record.full_name }
    end

  end


end
