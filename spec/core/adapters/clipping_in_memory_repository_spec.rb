require 'spec_helper'

describe Incollage::Repository::ClippingInMemoryRepository do

  before :each do
    @repo = Incollage::Repository::InMemoryBase.new
  end

  require app_root.join 'spec/core/support/clipping_repository_test'
  include ClippingRepositoryTest

  test_clipping_repository

end
