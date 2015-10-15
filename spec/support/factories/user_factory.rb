module TestFactories
  class UserFactory

    class << self

      def get(opts={})
        Incollage::User.new(defaults.merge opts)
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
