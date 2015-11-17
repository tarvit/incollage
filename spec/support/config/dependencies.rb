module TestSupport
  module Dependencies

    def with_repos
      with_user_repo
      with_clipping_repo
      with_linked_account_repo
    end

    def for_interactor
      with_repos
      with_holders
    end

    def with_all_gateways
      with_repos
      with_holders
      with_downloader
      with_uploader
      with_local_filestorage
      with_color_matcher
      with_collage_maker
      with_histogram_maker
    end

    def with_color_matcher
      Incollage::Service.register(:color_matcher, TestSupport::DirectColorMatcher.new)
    end

    def with_collage_maker(maker = TestSupport::FakeCollageMaker.new)
      Incollage::Service.register(:collage_maker, maker)
    end

    def with_downloader(downloader = TestSupport::FakeHttpDownloader.new)
      Incollage::Service.register(:downloader, downloader)
    end

    def with_uploader
      Incollage::Service.register(:uploader, TestSupport::FakeUploader.new)
    end

    def with_local_filestorage
      Incollage::Service.register(:local_filestorage, LocalFileStorage.new(app_root.join('tmp')))
    end

    def with_holders
      Incollage::Holder.register(:clippings_collections, collections_holder)
      Incollage::Holder.register(:external_accounts, external_accounts_holder)
    end

    def with_histogram_maker
      Incollage::Service.register(:histogram_maker, TestSupport::FakeHistogramMaker.new)
    end

    def with_user_repo
      Incollage::Repository.register(:user, Incollage::Repository::UserInMemoryRepository.new)
    end

    def with_clipping_repo
      Incollage::Repository.register(:clipping, Incollage::Repository::ClippingInMemoryRepository.new)
    end

    def with_linked_account_repo
      Incollage::Repository.register(:linked_account, Incollage::Repository::LinkedAccountInMemoryRepository.new)
    end

    def clear_gateways
      [ Incollage::Repository, Incollage::Service, Incollage::Holder ].each(&:clear)
    end

    private

    def collections_holder
      holder = Incollage::ExternalClippingsCollectionsHolder.new
      holder.add(
          id: 1,
          name: :test_collection,
          label: 'Test Collection',
          source: Incollage::ClippingsSource::InMemory::Source.new
      )
      holder
    end

    def external_accounts_holder
      holder = Incollage::ExternalAccountsHolder.new
      holder.add(
          id: 1,
          name: :test_account,
          label: 'External Account',
          connector: TestSupport::FakeAccountConnector.new(1),
          collections: [ Incollage::Holder.for_clippings_collections.get(:test_collection) ]
      )
      holder
    end
  end
end