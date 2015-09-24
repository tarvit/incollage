require 'spec_helper'

describe Incollage::UserCreator do

  it 'should create a user' do
    Incollage::UserCreator.new(Incollage::User.new).create
  end

end
