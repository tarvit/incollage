module TestFactories
  class ExternalAccountsHolderFactory

    def self.get(opts={})
      holder = Incollage::ExternalAccountsHolder.new
      holder.add({
          id: 1,
          name: :test_account,
          label: 'External Account',
          connector: TestSupport::FakeAccountConnector.new(1),
          collections: [ Incollage::Holder.for_clippings_collections.get(:test_collection) ]
      }.merge!(opts))
      holder
    end

  end
end
