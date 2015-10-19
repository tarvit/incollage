module TestFactories
  class UserFactory < RepositoryFactory

    class << self

      def entity
        Incollage::User
      end

      def repository
        Incollage::Repository.for_user
      end

      def defaults
        {
            full_name: 'J.D',
            username: 'johndoe'+SecureRandom.hex,
            password: 'q1w2e3r',
        }
      end

    end
  end
end
