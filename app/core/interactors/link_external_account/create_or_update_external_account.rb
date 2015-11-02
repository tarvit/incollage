module Incollage
  module LinkExternalAccount
    class CreateOrUpdateExternalAccount

      def initialize(attrs)
        @attributes = attrs
      end

      def execute
        create_or_update_account
      end

      protected

      def create_or_update_account
        Repository.for_linked_account.save(existing_account || build_entity)
      end

      def search_attributes
        attrs = @attributes.clone
        attrs.delete :external_meta_info
        attrs
      end

      def existing_account
        acc = Repository.for_linked_account.find(search_attributes)
        acc.external_meta_info = @attributes[:external_meta_info] if acc
        acc
      end

      def build_entity
        LinkedAccount.new(@attributes)
      end
    end
  end
end
