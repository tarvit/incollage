require 'spec_helper'

describe Incollage::Repository::ClippingInMemoryRepository do

  before :each do
    @repo = Incollage::Repository::InMemoryBase.new
  end

  context 'Base' do
    require app_root.join 'spec/core/support/base_repository_test'
    include BaseRepositoryTest

    test_base_repository
  end

  context 'Specific' do
    require app_root.join 'spec/core/support/clipping_repository_test'
    include ClippingRepositoryTest

    def new_entity(opts={})
      Incollage::Clipping.new(opts)
    end

    test_clipping_repository
  end

end
