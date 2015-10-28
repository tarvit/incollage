module TestFactories

  class StatsFactory

    def self.get
      {
          accounts: [
              {
                  :id => 11,
                  :name => :test_account,
                  :label => 'External Account',
                  :linked_account_id => 99,
                  :linked => true,
                  collections: [
                      {
                          :id => 22,
                          :name => :test_collection,
                          :label => 'Test Collection',
                          :clippings_count => 12,
                      }]}]}
    end
  end
end
