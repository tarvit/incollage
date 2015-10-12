require 'rails_helper'

describe ClippingActiveRecord::Repository do

  include ClippingRepositoryTest

  before :each do
    @repo = ClippingActiveRecord::Repository.new
  end

  test_clipping_repository

end
