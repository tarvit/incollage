module TestFactories

  class BaseFactory
    class << self
      def get(opts={})
        entity.new(defaults.merge opts)
      end

      def defaults
        raise NotImplementedError
      end

      def entity
        raise NotImplementedError
      end
    end
  end

  class RepositoryFactory < BaseFactory
    class << self

      def create(opts={})
        repository.save(get(opts))
      end

      def repository
        raise NotImplementedError
      end

    end
  end
end
