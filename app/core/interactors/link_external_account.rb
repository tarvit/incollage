module Incollage
  class LinkExternalAccount

    def initialize(attrs)
      @attributes = attrs
    end

    def execute
      Repository.for_linked_account.save(build_entity)
    end

    protected

    def build_entity
      LinkedAccount.new(@attributes)
    end

  end
end
