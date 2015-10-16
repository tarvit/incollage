require 'rails_helper'

describe ClippingActiveRecord::Repository do

  include UserRepositoryTest

  before :each do
    @repo = UserActiveRecord::Repository.new
  end

  test_user_repository

end
