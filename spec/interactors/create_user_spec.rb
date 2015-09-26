require 'spec_helper'

describe Incollage::CreateUser do

  it 'should create a user' do

    expect(->{
      Incollage::CreateUser.new({username: 'jd', full_name: 'Johny D'}).create
    }).to change{
      Incollage::Repository.for_user.count
    }.by(1)
  end

  it 'should find or create a user' do
    expect(Incollage::Repository.for_user.count).to eq(0)

    Incollage::CreateUser.new({username: 'jd', full_name: 'Johny D'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::CreateUser.new({username: 'jd', full_name: 'Johny D'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::CreateUser.new({username: 'bk', full_name: 'Billy K'}).find_or_create
    expect(Incollage::Repository.for_user.count).to eq(2)
  end

end
