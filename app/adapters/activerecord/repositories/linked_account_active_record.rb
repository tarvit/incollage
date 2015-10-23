class LinkedAccountActiveRecord < ActiveRecord::Base
  self.table_name = 'linked_accounts'

  class Repository < ActiveRecordBaseRepository

    protected

    def active_record
      LinkedAccountActiveRecord
    end

    def entity_class
      Incollage::LinkedAccount
    end

    def from_entity(entity)
      record = base_record(entity.id)
      record.user_id = entity.user_id
      record.external_user_id = entity.external_user_id
      record.external_account_id = entity.external_account_id
      record.external_meta_info = entity.external_meta_info.to_json
      record
    end

    def entity_attributes(record)
      {
          id: record.id,
          user_id: record.user_id,
          external_user_id: record.external_user_id,
          external_account_id: record.external_account_id,
          external_meta_info: parse_meta_info(record.external_meta_info),
      }
    end

    private

    def parse_meta_info(content)
      content.nil? ? {} : HashWithIndifferentAccess[JSON.parse(content)]
    end

  end

end
