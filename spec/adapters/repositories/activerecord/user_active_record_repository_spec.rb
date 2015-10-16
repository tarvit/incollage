require 'rails_helper'

describe ClippingActiveRecord::Repository do

  include UserRepositoryTest

  before :each do
    @repo = UserActiveRecord::Repository.new
  end

  def new_entity(opts={})
    attrs = { username: 'Joe', full_name: 'Doe' }
    Incollage::User.new(attrs.merge opts)
  end

  test_user_repository


end
