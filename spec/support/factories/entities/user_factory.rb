module TestFactories
  class UserFactory < BaseFactory

    class << self

      def entity
        Incollage::User
      end

      def defaults
        {
            id: 1,
            full_name: 'J.D',
            username: 'johndoe',
        }
      end

    end
  end
end
