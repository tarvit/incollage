require 'spec_helper'

describe Incollage::Repository::LinkedAccountInMemoryRepository do

  include BaseRepositoryTest

  before :each do
    @repo = Incollage::Repository::LinkedAccountInMemoryRepository.new
  end

  test_base_repository

end
