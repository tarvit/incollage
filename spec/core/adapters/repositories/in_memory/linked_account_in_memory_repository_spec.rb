require 'spec_helper'

describe Incollage::Repository::LinkedAccountInMemoryRepository do

  include LinkedAccountRepositoryTest

  before :each do
    @repo = Incollage::Repository::LinkedAccountInMemoryRepository.new
  end

  test_linked_account_repository

end
