require 'spec_helper'

describe Incollage::Repository::InMemoryBase do
  require app_root.join 'spec/core/support/base_repository_test'
  include BaseRepositoryTest

  before :each do
    @repo = Incollage::Repository::InMemoryBase.new
  end

  test_in_memory_base_repository

end
