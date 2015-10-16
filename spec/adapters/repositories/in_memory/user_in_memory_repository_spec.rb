require 'spec_helper'

describe Incollage::Repository::UserInMemoryRepository do

  include UserRepositoryTest

  before :each do
    @repo = Incollage::Repository::UserInMemoryRepository.new
  end

  test_user_repository

end
