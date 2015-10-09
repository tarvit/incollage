require 'spec_helper'

describe Incollage::Repository::ClippingInMemoryRepository do

  require app_root.join 'spec/core/support/clipping_repository_test'
  include ClippingRepositoryTest

  before :each do
    @repo = Incollage::Repository::InMemoryBase.new
  end

  test_clipping_repository

end
