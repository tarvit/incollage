class UserActiveRecord < ActiveRecord::Base
  self.table_name = 'users'

  validates_uniqueness_of :username

  class Repository < ActiveRecordBaseRepository

    def username_occupied?(username)
      exists?(username: username)
    end

    protected

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
      record.password_digest = entity.password_digest
      record
    end

    def entity_attributes(record)
      {
          id: record.id,
          username: record.username,
          full_name: record.full_name,
          password_digest: record.password_digest,
      }
    end
  end

end
