require 'spec_helper'

describe LinkedAccountActiveRecord::Repository do

  include LinkedAccountRepositoryTest

  before :each do
    @repo = LinkedAccountActiveRecord::Repository.new
  end

  test_linked_account_repository

end
