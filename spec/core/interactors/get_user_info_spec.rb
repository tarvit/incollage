require 'spec_helper'

describe Incollage::GetUserInfo do

  before :each do |example|
    example.with_user_repo

    @user = TestFactories::UserFactory.create(id: 100, username: 'jdoe', full_name: 'johny deep')
  end

  it 'should add a clipping' do
    response = Incollage::GetUserInfo.new(@user.id).execute
    expect(response).to eq(id: 100, username: 'jdoe', full_name: 'johny deep')
  end

end
