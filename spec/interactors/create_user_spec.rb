require 'spec_helper'

describe Incollage::UserCreator do

  it 'should create a user' do

    expect(->{
      Incollage::UserCreator.new({full_name: 'Johny D'}).create
    }).to change{
      Incollage::Repository.for_user.count
    }.by(1)
  end

  it 'should find or create a user' do
    expect(Incollage::Repository.for_user.count).to eq(0)

    Incollage::UserCreator.new({full_name: 'Johny D'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::UserCreator.new({full_name: 'Johny D'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::UserCreator.new({full_name: 'Billy K'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(2)
  end

end
