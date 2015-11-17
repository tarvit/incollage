module TestFactories
  class CollectionsHolderFactory

    def self.get(opts={})
      holder = Incollage::ExternalClippingsCollectionsHolder.new
      holder.add({
          id: 1,
          name: :test_collection,
          label: 'Test Collection',
          source: Incollage::ClippingsSource::InMemory::Source.new
      }.merge!(opts))
      holder
    end

  end
end
