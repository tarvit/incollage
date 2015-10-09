require 'spec_helper'

describe ClippingActiveRecord::Repository do

  require app_root.join 'spec/core/support/clipping_repository_test'
  include ClippingRepositoryTest

  before :each do
    @repo = ClippingActiveRecord::Repository.new
  end

  test_clipping_repository

end
