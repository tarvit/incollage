module Incollage

  module Repository

    class Base

      def save(entity, options={})
        raise NotImplementedError
      end

      def update_all(entities, options={})
        raise NotImplementedError
      end

      def delete(entity, options={})
        raise NotImplementedError
      end

      def delete_all(options={})
        raise NotImplementedError
      end

      def find(options)
        raise NotImplementedError
      end

      def find_all(options)
        raise NotImplementedError
      end

      def all(options={})
        raise NotImplementedError
      end

      def first
        raise NotImplementedError
      end

      def last
        raise NotImplementedError
      end

      def count
        all.count
      end

      alias_method :take, :first

    end

    class EntityIsInvalidError < StandardError

    end
  end
end
