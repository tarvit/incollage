require 'spec_helper'

describe Incollage::Repository::InMemoryBase do

  context 'Base' do
    include BaseRepositoryTest

    before :each do
      @repo = Incollage::Repository::InMemoryBase.new
    end

    test_base_repository
  end

end
