require 'spec_helper'

describe Incollage::UserCreator do

  it 'should create a user' do
    expect(->{
      Incollage::UserCreator.new(Incollage::User.new).create
    }).to change{
      Incollage::Repository.for_user.count
    }.by(1)

  end

end
