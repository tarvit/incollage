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
      Incollage::Holder.register(:clippings_collections, TestFactories::CollectionsHolderFactory.get)
      Incollage::Holder.register(:external_accounts, TestFactories::ExternalAccountsHolderFactory.get)
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
  end
end