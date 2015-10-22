require 'spec_helper'

describe Incollage::Repository::ClippingInMemoryRepository do

  include ClippingRepositoryTest

  before :each do
    @repo = Incollage::Repository::ClippingInMemoryRepository.new
  end

  test_clipping_repository

end
