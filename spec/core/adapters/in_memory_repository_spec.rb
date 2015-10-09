require 'spec_helper'

describe Incollage::Repository::InMemoryBase do
  require_relative '../../../spec/core/support/in_memory_base_repository'
  include InMemoryBaseRepositoryTest

  before :each do
    @repo = Incollage::Repository::InMemoryBase.new
  end

  test_in_memory_base_repository

end
